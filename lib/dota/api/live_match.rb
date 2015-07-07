module Dota
  module API
    class LiveMatch < BasicMatch
      def duration
        raw["scoreboard"]["duration"]
      end

      def league_id
        raw["league_id"]
      end

      def league_tier
        League::TIERS[raw["league_tier"]]
      end

      def lobby_id
        raw["lobby_id"]
      end

      def spectators_count
        raw["spectators"]
      end

      def stream_delay
        raw["stream_delay_s"]
      end

      def series_type
        raw["series_type"]
      end

      def roshan_timer
        raw["scoreboard"]["roshan_respawn_timer"]
      end

      def radiant
        @radiant ||= Side.new(raw_side(:radiant))
      end

      def dire
        @dire ||= Side.new(raw_side(:dire))
      end

      private

      def raw_side(type)
        raw_side = (raw_team(type) || {})
          .merge(raw["scoreboard"]["#{type}"])
          .merge("series_wins" => raw["#{type}_series_wins"])
        merge_player_names(raw_side)
      end

      def raw_team(type)
        raw["#{type}_team"]
      end

      def merge_player_names(raw_side)
        raw_side["players"].map! do |player|
          id = player["account_id"]
          player.merge("name" => player_name_from_id(id))
        end
        raw_side
      end

      def player_name_from_id(id)
        player = raw["players"].detect { |p| id == p["account_id"] }
        player["name"]
      end
    end
  end
end
