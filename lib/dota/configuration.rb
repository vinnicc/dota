module Dota
  class Configuration
    DEFAULT_API_VERSION = "v1"
    OPTIONS = [:api_key, :api_version].freeze

    attr_accessor :api_key, :api_version

    def initialize
      @api_version = DEFAULT_API_VERSION
    end
  end
end
