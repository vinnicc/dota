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

      def league_id
        raw["league_id"]
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

      # lookup league details
      #def league_id
      #  raw["league_id"]
      #end

    end
  end
end
