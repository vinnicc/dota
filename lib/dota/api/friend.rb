module Dota
  module API
    class Friend < Entity
      def id
        raw["steamid"].to_i
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
