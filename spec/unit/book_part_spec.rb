require 'spec_helper'

RSpec.describe FedoraDownloader::BookPart do
  before do
    @mock_api = Rubydora::Fc3Service.new({})
    @mock_repository = Rubydora::Repository.new({}, @mock_api)
  end

  let(:book_part) { described_class.new 'pid', @mock_api }

  it 'should load a BookPart instance' do
    expect(book_part).to be_a_kind_of(FedoraDownloader::BookPart)
  end
end
