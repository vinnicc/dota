module Dota
  module API
    class LiveMatch
      class Player < BasicPlayer
        def name
          raw["name"]
        end

        def deaths
          raw["death"]
        end

        def ultimate_state
          raw["ultimate_state"]
        end

        def ultimate_cooldown
          raw["ultimate_cooldown"]
        end

        def position_x
          raw["position_x"]
        end

        def position_y
          raw["position_y"]
        end

        def net_worth
          raw["net_worth"]
        end

        def respawn_timer
          raw["respawn_timer"]
        end

        def items
          (0..5).map { |i| Item.new(raw["item#{i}"]) }
        end
      end
    end
  end
end
