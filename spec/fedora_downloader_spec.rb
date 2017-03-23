require 'spec_helper'

RSpec.describe FedoraDownloader do
  it 'has a version number' do
    expect(FedoraDownloader::VERSION).not_to be nil
  end
end
