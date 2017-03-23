module FedoraDownloader
  class RubydoraConnection
    attr_accessor :options, :connection

    def initialize(params = {})
      params = params.dup
      self.options = params
      connect
    end

    def connect(force = false)
      return unless @connection.nil? || force
      allowable_options = [:url, :user, :password]
      client_options = options.reject { |k, _v| !allowable_options.include?(k) }
      @connection = Rubydora.connect client_options
    end
  end
end
