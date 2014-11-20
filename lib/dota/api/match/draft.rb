module Dota
  module API
    class Match
      class Draft
        include Utilities::Inspectable

        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def order
          raw["order"] + 1
        end

        def pick?
          raw["is_pick"]
        end

        def team
          raw["team"] == 0 ? :radiant : :dire
        end

        def hero
          Hero.new(raw["hero_id"])
        end
      end
    end
  end
end
