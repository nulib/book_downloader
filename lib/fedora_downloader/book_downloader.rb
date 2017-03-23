require 'csv'
require 'fedora_downloader/datastreams/book'
require 'fedora_downloader/rubydora_connection'
require 'rubydora'

module FedoraDownloader
  class BookDownloader
    def initialize(csv_file, output_path)
      @csv_file = csv_file
      @output_path = output_path
    end

    # Loop through CSV of bib_numbers downloading the pages each book
    # to the output directory specified in the .env file
    def process
      count = 0
      CSV.foreach(@csv_file, headers: true) do |book|
        pid = "inu:inu-mntb-000#{book['bib_number']}-bk"
        book = Book.find(pid, FedoraDownloader.repo.connection)
        book.download(@output_path)
        count += 1
      end
      count
    end
  end
end
