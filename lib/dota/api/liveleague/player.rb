module Dota
  module API
    class LiveLeague
      class Player
        
        TEAM = {
          0 => "Radiant",
          1 => "Dire",
          2 => "Broadcaster",
          4 => "Unassigned"
          }.freeze

        include Utilities::Inspectable

        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def account_id
          raw["account_id"]
        end

        def name
          raw["name"]
        end

        def hero
          Hero.new(raw["hero_id"])
        end

        def team
          raw["team"]
        end
      end
    end
  end
end