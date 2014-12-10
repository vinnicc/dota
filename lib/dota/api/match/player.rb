module Dota
  module API
    class Match
      class Player < BasicPlayer
        def status
          STATUS[raw["leaver_status"]]
        end

        def deaths
          raw["deaths"]
        end

        def gold_spent
          raw["gold_spent"]
        end

        def hero_damage
          raw["hero_damage"]
        end

        def tower_damage
          raw["tower_damage"]
        end

        def hero_healing
          raw["hero_healing"]
        end

        def items
          (0..5).map { |i| Item.new(raw["item_#{i}"]) }
        end
      end
    end
  end
end
