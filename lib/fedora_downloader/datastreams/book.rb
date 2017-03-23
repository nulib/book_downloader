# frozen_string_literal: true
require 'rubydora'
require 'fedora_downloader/datastreams/book_part'

# Class for processing page images of a book object in Fedora 3
# whose pages are downloaded to a directory specified in config.yml
module FedoraDownloader
  class Book < Rubydora::DigitalObject
    def download(output_path)
      FedoraDownloader::Logging.logger.info "PROCESSING BOOK: #{pid}"
      dir = find_or_create_output_path(output_path.chomp('/'))
      pages.each { |page| page.process_image(dir) }
      FedoraDownloader::Logging.logger.info "COMPLETED PROCESSING BOOK: #{pid}"
    end

    private

    def pages
      parts.map { |part| BookPart.find(part.pid, part.repository) if BookPart.valid_page?(part) }
    end

    def find_or_create_output_path(output_path)
      book_path = "#{output_path}/#{bib_number}"
      FileUtils.mkdir_p(book_path) unless Dir.exist?(book_path)
      raise 'Book directory does not exist' unless Dir.exist?(book_path)
      book_path
    end

    # pid example: inu:inu-mntb-0006337684-bk
    def bib_number
      pid.gsub('inu:inu-mntb-000', '').gsub('-bk', '')
    end
  end
end
