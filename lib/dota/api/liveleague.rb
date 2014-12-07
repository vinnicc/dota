module Dota
  module API
    class LiveLeague
      include Utilities::Inspectable

      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def lobby_id
        raw["lobby_id"]
      end

      def match_id
        raw["match_id"]
      end

      def spectators
        raw["spectators"]
      end

      def league
        league_id = raw["league_id"]
        leagues = Dota.api.leagues
        leagues.detect { |league| league.id == league_id }
      end

      def stream_delay
        raw["stream_delay_s"]
      end

      def radiant_series_wins
        raw["radiant_series_wins"]
      end

      def dire_series_wins
        raw["dire_series_wins"]
      end

      def series_type
        raw["series_type"]
      end

      def league_tier
        raw["league_tier"]
      end

      #def scoreboard

      #def players
      # - account_id
      # - name
      # - hero_id
      # - team (0,1,2,4)
    end
  end
end
