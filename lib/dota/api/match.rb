module Dota
  module API
    class Match
      include Utilities::Inspectable

      TYPES = {
        -1 => "Invalid",
        0 => "Public Matchmaking",
        1 => "Practice",
        2 => "Tournament",
        3 => "Tutorial",
        4 => "Co-op with Bots",
        5 => "Team Match",
        6 => "Solo Queue"
      }.freeze

      MODES = {
        0 => "None",
        1 => "All Pick",
        2 => "Captain's Mode",
        3 => "Random Draft",
        4 => "Single Draft",
        5 => "All Random",
        6 => "Intro",
        7 => "Diretide",
        8 => "Reverse Captain's Mode",
        9 => "The Greeviling",
        10 => "Tutorial",
        11 => "Mid Only",
        12 => "Least Played",
        13 => "New Player Pool",
        14 => "Compendium Matchmaking",
        16 => "Captain's Draft"
      }.freeze

      SKILL_LEVELS = {
        0 => "Any",
        1 => "Normal",
        2 => "High",
        3 => "Very High"
      }.freeze

      def initialize(raw)
        @raw = raw
      end

      def id
        raw["match_id"]
      end

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

      def human_players
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

      private

      attr_reader :raw
    end
  end
end
