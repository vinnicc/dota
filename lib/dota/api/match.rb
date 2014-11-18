module Dota
  module API
    class Match
      include Utilities::Inspectable

      def initialize(raw)
        @raw = raw
      end

      def id
        raw["match_id"]
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

      def human_players
        raw["human_players"]
      end

      def cluster
        raw["cluster"]
      end

      def mode
        raw["game_mode"]
      end

      def lobby
        raw["lobby_type"]
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

      def players
        raw["players"].map do |raw_player|
          Player.new(raw_player)
        end
      end

      def drafts
        raw["picks_bans"].map do |raw_draft|
          Draft.new(raw_draft)
        end
      end

      private

      attr_reader :raw
    end
  end
end
