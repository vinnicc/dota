module Dota
  module API
    class League
      include Utilities::Inspectable

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

      private

      attr_reader :raw
    end
  end
end
