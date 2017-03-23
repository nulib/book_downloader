require 'dotenv'
Dotenv.load('.env.development')

require 'fedora_downloader/version'
raise "FedoraDownloader #{FedoraDownloader::VERSION} does not support Ruby versions below 2.3.0." if RUBY_VERSION < '2.3.0'

require 'fedora_downloader/book_downloader'
require 'fedora_downloader/logging'
require 'yaml'

module FedoraDownloader
  def self.logger
    FedoraDownloader::Logging.logger
  end

  def self.logger=(log)
    FedoraDownloader::Logging.logger = log
  end

  def self.repo
    connection_configs = { url: ENV['FEDORA_REPO'],
                           user: ENV['FEDORA_USER'],
                           password: ENV['FEDORA_PASSWORD'] }
    @source ||= FedoraDownloader::RubydoraConnection.new(connection_configs)
  end
end
