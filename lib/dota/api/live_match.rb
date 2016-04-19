module Dota
  module API
    class LiveMatch < BasicMatch
      def duration
        raw_scoreboard["duration"]
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
        raw_scoreboard["roshan_respawn_timer"]
      end

      def radiant
        @radiant ||= Side.new(raw_side("radiant"))
      end

      def dire
        @dire ||= Side.new(raw_side("dire"))
      end

      private

      def raw_scoreboard
        raw["scoreboard"] || {
          "radiant" => { "players" => [] },
          "dire" => { "players" => [] },
        }
      end

      def raw_side(type)
        side_scoreboard = raw_scoreboard[type]
        side_players = side_scoreboard["players"].map do |player|
          player.merge("name" => player_name_from_id(player["account_id"]))
        end

        (raw["#{type}_team"] || {})
          .merge(side_scoreboard)
          .merge("players" => side_players)
          .merge("series_wins" => raw["#{type}_series_wins"])
      end

      def player_name_from_id(id)
        raw["players"].detect { |p| id == p["account_id"] }["name"]
      end
    end
  end
end
