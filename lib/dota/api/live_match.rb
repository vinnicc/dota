module Dota
  module API
    class LiveMatch
      LEAGUE_TIERS = {
        1 => "Amateur",
        2 => "Professional",
        3 => "Premier"
      }

      include Utilities::Inspectable

      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def lobby_id
        raw["lobby_id"]
      end

      def id
        raw["match_id"]
      end

      def spectators_count
        raw["spectators"]
      end

      def league_id
        raw["league_id"]
      end

      def stream_delay
        raw["stream_delay_s"]
      end

      def radiant_wins
        raw["radiant_series_wins"]
      end

      def dire_wins
        raw["dire_series_wins"]
      end

      def radiant
        Side.new(raw["radiant_team"])
      end

      def dire
        Side.new(raw["dire_team"])
      end

      def series_type
        raw["series_type"]
      end

      def league_tier
        LEAGUE_TIERS[raw["league_tier"]]
      end

      def players
        raw["players"].map do |raw_player|
          Player.new(raw_player)
        end
      end

      def scoreboard
        Scoreboard.new(raw["scoreboard"])
      end
    end
  end
end
