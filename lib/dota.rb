require 'dota/configuration'
require 'dota/version'

require 'dota/utils/inspect'

require 'dota/api/entity'

require 'dota/api/basic_match'
require 'dota/api/basic_player'
require 'dota/api/client'
require 'dota/api/cosmetic/rarity'
require 'dota/api/friend'
require 'dota/api/hero'
require 'dota/api/item'
require 'dota/api/league'
require 'dota/api/live_match'
require 'dota/api/live_match/player'
require 'dota/api/live_match/side'
require 'dota/api/match'
require 'dota/api/match/draft'
require 'dota/api/match/player'
require 'dota/api/team'

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
