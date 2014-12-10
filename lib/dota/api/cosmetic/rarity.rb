module Dota
  module API
    class Cosmetic
      class Rarity < Entity
        def id
          raw["id"]
        end

        def order
          raw["order"]
        end

        def color
          raw["color"]
        end

        def name
          raw["localized_name"]
        end
      end
    end
  end
end
