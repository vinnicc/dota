module Dota
  module API
    class League
      include Utilities::Inspectable

      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

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
    end
  end
end
