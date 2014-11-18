require 'dota/configuration'
require 'dota/version'

require 'dota/utils/inspect'

require 'dota/api/client'
require 'dota/api/hero'
require 'dota/api/item'
require 'dota/api/league'
require 'dota/api/match'
require 'dota/api/match/player'

module Dota
  class << self
    attr_writer :configuration

    def api
      @client ||= API::Client.new
    end

    def configure(&block)
      api.configure(&block)
    end

    def configuration
      api.configuration
    end
  end
end
