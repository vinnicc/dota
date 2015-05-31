require 'faraday'
require 'faraday_middleware'

module Dota
  module API
    class Client
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield configuration
      end

      def heroes(id = nil)
        id ? Hero.new(id) : Hero.all
      end

      def items(id = nil)
        id ? Item.new(id) : Item.all
      end

      def abilities(id = nil)
        id ? Ability.new(id) : Ability.all
      end

      def teams(options = {})
        if options.is_a?(Integer)
          id = options
          response = get("IDOTA2Match_570", "GetTeamInfoByTeamID", start_at_team_id: id, teams_requested: 1)["result"]["teams"][0]
          Team.new(response) if response
        else
          options[:start_at_team_id] = options.delete(:after) if options[:after]
          options[:teams_requested]  = options.delete(:limit) if options[:limit]

          response = get("IDOTA2Match_570", "GetTeamInfoByTeamID", options)["result"]
          if response && (teams = response["teams"] || [])
            teams.map { |team| Team.new(team) }
          end
        end
      end

      def matches(options = {})
        if options.is_a?(Integer)
          id = options
          response = get("IDOTA2Match_570", "GetMatchDetails", match_id: id)["result"]
          Match.new(response) if response
        else
          options[:game_mode]             = options.delete(:mode_id) if options[:mode_id]
          options[:skill]                 = options.delete(:skill_level) if options[:skill_level]
          options[:date_min]              = options.delete(:from) if options[:from]
          options[:date_max]              = options.delete(:to) if options[:to]
          options[:account_id]            = options.delete(:player_id) if options[:player_id]
          options[:start_at_match_id]     = options.delete(:after) if options[:after]
          options[:matches_requested]     = options.delete(:limit) if options[:limit]
          options[:tournament_games_only] = options.delete(:league_only) if options[:league_only]

          response = get("IDOTA2Match_570", "GetMatchHistory", options)["result"]
          if response && (matches = response["matches"] || [])
            matches.map { |match| Match.new(match) }
          end
        end
      end

      def leagues
        response = get("IDOTA2Match_570", "GetLeagueListing", language: "en")["result"]
        if response && (leagues = response["leagues"] || [])
          leagues.map { |league| League.new(league) }
        end
      end

      def live_matches(options = {})
        response = get("IDOTA2Match_570", "GetLiveLeagueGames", options)["result"]
        if response && (live_matches = response["games"] || [])
          live_matches.map { |game| LiveMatch.new(game) }
        end
      end

      def scheduled_matches(options = {})
        options[:date_min] = options.delete(:from) if options[:from]
        options[:date_max] = options.delete(:to) if options[:to]

        response = get("IDOTA2Match_570", "GetScheduledLeagueGames", options)["result"]
        if response && (scheduled_matches = response["games"] || [])
          scheduled_matches.map { |game| ScheduledMatch.new(game) }
        end
      end

      def cosmetic_rarities
        response = get("IEconDOTA2_570", "GetRarities", language: "en")["result"]
        if response && (rarities = response["rarities"] || [])
          rarities.map { |rarity| Cosmetic::Rarity.new(rarity) }
        end
      end

      def friends(user_id)
        response = get("ISteamUser", "GetFriendList", steamid: user_id)["friendslist"]
        if response && (friends = response["friends"] || [])
          friends.map { |friend| Friend.new(friend) }
        end
      end

      def get(interface, method, params = {}, *args)
        do_request(method, params, interface, *args)
      end

      private

      def do_request(method, params, interface = "IDOTA2Match_570", method_version = nil)
        method_version = params.delete(:api_version) || configuration.api_version
        url = "https://api.steampowered.com/#{interface}/#{method}/#{method_version}/"

        @faraday = Faraday.new(url) do |faraday|
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end

        response = @faraday.get do |request|
          request.url(url, params.merge(key: configuration.api_key))
        end
        response.body
      end
    end
  end
end
