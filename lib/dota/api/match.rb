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

      def players
        raw["players"].map do |raw_player|
          Player.new(raw_player)
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

      def radiant_tower_status
        raw["tower_status_radiant"]
      end

      def dire_tower_status
        raw["tower_status_dire"]
      end

      def radiant_barracks_status
        raw["barracks_status_radiant"]
      end

      def dire_barracks_status
        raw["barracks_status_dire"]
      end

      def radiant_id
        raw["radiant_team_id"]
      end

      def radiant_name
        raw["radiant_name"]
      end

      def radiant_logo_id
        raw["radiant_logo"]
      end

      def radiant_complete?
        raw["radiant_team_complete"] == 1
      end

      def radiant_captain_id
        raw["radiant_captain"]
      end

      def dire_id
        raw["dire_team_id"]
      end

      def dire_name
        raw["dire_name"]
      end

      def dire_logo_id
        raw["dire_logo"]
      end

      def dire_complete?
        raw["dire_team_complete"] == 1
      end

      def dire_captain_id
        raw["dire_captain"]
      end
    end
  end
end
