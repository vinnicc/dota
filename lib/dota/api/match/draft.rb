module Dota
  module API
    class Match
      class Draft < Entity
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
