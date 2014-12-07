module Dota
  module API
    class LiveLeague
      include Utilities::Inspectable

      attr_reader :raw

      def players
        raw["players"].map do |raw_player|
          Player.new(raw_player)
        end
      end

      def lobby_id

      end

    end
  end
end
