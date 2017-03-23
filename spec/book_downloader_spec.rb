require 'spec_helper'
require 'fedora_downloader/book_downloader'

RSpec.describe FedoraDownloader::BookDownloader do
  after :example do
    FileUtils.rm_rf mock_download_directory if File.exist?(mock_download_directory)
  end

  let(:csv_file) { 'spec/fixtures/test.csv' }
  let(:mock_download_directory) { 'spec/mock_download_directory' }
  let(:importer) { described_class.new(csv_file, mock_download_directory) }

  xit 'processes books' do
    expect(importer).to receive(:download).exactly(1).times
    importer.process
  end
end
