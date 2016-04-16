module Dota
  module API
    class League < Entity
      TIERS = {
        1 => "Amateur",
        2 => "Professional",
        3 => "Premier"
      }

      def id
        raw["leagueid"]
      end

      def name
        raw["name"]
      end

      def description
        raw["description"]
      end

      def url
        raw["tournament_url"]
      end

      def itemdef
        raw["itemdef"]
      end
    end
  end
end
