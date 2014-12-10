module Dota
  module API
    class LiveMatch
      include Utilities::Inspectable

      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def id
        raw["match_id"]
      end

      def lobby_id
        raw["lobby_id"]
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

      def radiant_series_wins
        raw["radiant_series_wins"]
      end

      def dire_series_wins
        raw["dire_series_wins"]
      end

      def radiant
        Side.new(raw_for_side(:radiant))
      end

      def dire
        Side.new(raw_for_side(:dire))
      end

      def series_type
        raw["series_type"]
      end

      def league_tier
        League::TIERS[raw["league_tier"]]
      end

      def duration
        raw["scoreboard"]["duration"]
      end

      def roshan_timer
        raw["scoreboard"]["roshan_respawn_timer"]
      end

      private

      def raw_for_side(player_type)
        raw_side = raw["#{player_type}_team"].merge(raw["scoreboard"]["#{player_type}"])
        merge_player_names!(raw_side["players"])
        raw_side
      end

      def merge_player_names!(raw_side_players)
        raw_side_players.map! do |player|
          id = player["account_id"]
          player.merge("name" => player_name_from_id(id))
        end
      end

      def player_name_from_id(id)
        player = raw["players"].detect { |player| id == player["account_id"] }
        player["name"]
      end
    end
  end
end
