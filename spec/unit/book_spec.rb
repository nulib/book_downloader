require 'spec_helper'

RSpec.describe FedoraDownloader::Book do
  before do
    @mock_api = Rubydora::Fc3Service.new({})
    @mock_repository = Rubydora::Repository.new({}, @mock_api)
  end

  let(:book) { described_class.new 'pid', @mock_api }

  it 'should load a Book instance' do
    expect(book).to be_a_kind_of(FedoraDownloader::Book)
  end
end
