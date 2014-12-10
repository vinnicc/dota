module Dota
  module API
    class LiveMatch
      class Player
        include Utilities::Inspectable

        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def id
          raw["account_id"]
        end

        def name
          raw["name"]
        end

        def hero
          Hero.new(raw["hero_id"])
        end

        def team
          case raw["team"]
          when 0
            :radiant
          when 1
            :dire
          when 2
            :broadcaster
          when 4
            :unassigned
          end
        end
      end
    end
  end
end
