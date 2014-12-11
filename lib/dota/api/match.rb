module Dota
  module API
    class Match < BasicMatch
      def mode
        MODES[raw["game_mode"]]
      end

      def mode_id
        raw["game_mode"]
      end

      def type
        TYPES[raw["lobby_type"]]
      end

      def type_id
        raw["lobby_type"]
      end

      def drafts
        raw["picks_bans"].map do |raw_draft|
          Draft.new(raw_draft)
        end
      end

      def sequence
        raw["match_seq_num"]
      end

      def starts_at
        Time.at(raw["start_time"])
      end

      def duration
        raw["duration"]
      end

      def first_blood
        raw["first_blood_time"]
      end

      def winner
        raw["radiant_win"] ? :radiant : :dire
      end

      def positive_votes
        raw["positive_votes"]
      end

      def negative_votes
        raw["negative_votes"]
      end

      def season
        raw["season"]
      end

      def league_id
        raw["leagueid"]
      end

      def players_count
        raw["human_players"]
      end

      def cluster
        raw["cluster"]
      end

      def radiant
        Side.new(raw_for_side(:radiant))
      end

      def dire
        Side.new(raw_for_side(:dire))
      end

      private

      def raw_for_side(type)
        pattern = /^#{type}_|_#{type}$/
        raw_side = raw.select { |k, v| k.to_s.match(pattern) }
        raw_side = Hash[raw_side.map { |k, v| [k.sub(pattern, ""), v] }]
        raw_side.merge("players" => players_for_side(type))
      end

      def players_for_side(type)
        raw["players"].select do |player|
          case type
          when :radiant
            player["player_slot"] < 100
          when :dire
            player["player_slot"] > 100
          end
        end
      end
    end
  end
end
