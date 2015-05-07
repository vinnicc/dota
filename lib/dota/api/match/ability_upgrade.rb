module Dota
  module API
    class Match
      class AbilityUpgrade
        attr_reader :ability, :level, :time

        def initialize(raw)
          @ability = Ability.new(raw["ability"])
          @level = raw["level"]
          @time = raw["time"]
        end
      end
    end
  end
end