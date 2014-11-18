module Dota
  module API
    class Match
      class Draft
        def initialize(raw)
          @raw = raw
        end

        def order
          raw["order"] + 1
        end

        def pick?
          raw["is_pick"]
        end

        def hero
          Hero.new(raw["hero_id"])
        end

        private

        attr_reader :raw
      end
    end
  end
end
