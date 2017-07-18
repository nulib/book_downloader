# frozen_string_literal: true

require 'rubydora'
require 'fileutils'
require 'uri'

module FedoraDownloader
  # Class for validating book parts and downloading
  # datastream content to a file based on it's dsLocation
  class BookPart < Rubydora::DigitalObject
    def self.valid_page?(obj)
      obj.models.include?('info:fedora/inu:mntb-page-001-cmodel') && obj.datastreams[ENV['DATASTREAM']].has_content?
    end

    def process_image(dir)
      download_path = make_subdirectory(dir)
      if File.exist?(download_path)
        FedoraDownloader.logger.info("#{download_path} already exists")
      else
        download(download_path)
      end
      verify_image(download_path)
    end

    private

    def make_subdirectory(dir)
      url = datastreams[ENV['DATASTREAM']].dsLocation
      base_path = URI.parse(url).path
      base_dir = File.dirname(base_path)
      download_dir = FileUtils.mkdir_p("#{dir}#{base_dir}").first
      "#{download_dir}/#{File.basename(base_path)}"
    end

    def verify_image(file_path)
      FedoraDownloader.logger.error "FILE NOT FOUND: #{file_path}" unless File.file?(file_path)
      if File.zero?(file_path)
        FedoraDownloader.logger.error "PROBLEM DOWNLOADING: #{pid}"
        FileUtils.rm_f(file_path)
      else
        FedoraDownloader.logger.info "SUCCESSFULLY CREATED: #{file_path}"
      end
    end

    def download(file_path)
      f = File.new(file_path, 'wb')
      f << datastreams['PROC-IMG'].content.body
      f.close
    end
  end
end
