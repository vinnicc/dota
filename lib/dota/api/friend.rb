module Dota
  module API
    class Friend
      include Utilities::Inspectable

      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end

      def id
        raw["steamid"]
      end

      def relationship
        raw["relationship"]
      end

      def friended_at
        Time.at(raw["friend_since"])
      end
    end
  end
end
