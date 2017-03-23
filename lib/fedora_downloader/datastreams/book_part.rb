# frozen_string_literal: true
require 'rubydora'
require 'fileutils'

module FedoraDownloader
  # Class for validating book parts and downloading
  # datastream content to a file based on it's dsLocation
  class BookPart < Rubydora::DigitalObject
    def self.valid_page?(obj)
      obj.models.include?('info:fedora/inu:mntb-page-001-cmodel') && obj.datastreams[ENV['DATASTREAM']].has_content?
    end

    def process_image(dir)
      FedoraDownloader::Logging.logger.info "DOWNLOADING PAGE: #{pid}"
      file_path = "#{dir}/#{File.basename(datastreams[ENV['DATASTREAM']].dsLocation)}"
      download(file_path) unless File.exist? file_path
      verify_image(file_path)
    end

    private

    def verify_image(file_path)
      FedoraDownloader::Logging.logger.error "FILE NOT FOUND: #{file_path}" unless File.file?(file_path)
      if File.zero?(file_path)
        FedoraDownloader::Logging.logger.error "PROBLEM DOWNLOADING: #{pid}"
        FileUtils.rm_f(file_path)
      else
        FedoraDownloader::Logging.logger.info "SUCCESSFULLY CREATED: #{file_path}"
      end
    end

    def download(file_path)
      f = File.new(file_path, 'wb')
      f << datastreams['PROC-IMG'].content.body
      f.close
    end
  end
end
