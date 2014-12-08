module Dota
  module API
    class Team
      include Utilities::Inspectable

      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def id
        raw["team_id"]
      end

      def name
        raw["name"]
      end

      def tag
        raw["tag"]
      end

      def country_code
        raw["country_code"]
      end

      def rating
        raw["rating"]
      end

      def url
        raw["url"]
      end

      def logo_id
        raw["logo"]
      end

      def sponsor_logo_id
        raw["logo_sponsor"]
      end

      def matches_with_current_roster
        raw["games_played_with_current_roster"]
      end

      def player_ids
        (0..4).map { |n| raw["player_#{n}_account_id"] }
      end

      def admin_id
        raw["admin_account_id"]
      end

      def created_at
        Time.at(raw["time_created"])
      end
    end
  end
end
