module Dota
  module API
    class Cosmetic
      class Rarity
        def initialize(raw)
          @raw = raw
        end

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

        private

        attr_reader :raw
      end
    end
  end
end
