module Dota
  module API
    class LiveMatch
      class Player
        TYPES = {
          0 => :radiant,
          1 => :dire,
          2 => :broadcaster,
          4 => :unassigned
        }

        include Utilities::Inspectable

        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def id
          raw["account_id"]
        end

        def slot
          raw["player_slot"]
        end

        def name
          raw["name"]
        end

        def hero
          Hero.new(raw["hero_id"])
        end

        def level
          raw["level"]
        end

        def kills
          raw["kills"]
        end

        def deaths
          raw["death"]
        end

        def assists
          raw["assists"]
        end

        def last_hits
          raw["last_hits"]
        end

        def denies
          raw["denies"]
        end

        def ultimate_state
          raw["ultimate_state"]
        end

        def ultimate_cooldown
          raw["ultimate_cooldown"]
        end

        def gold
          raw["gold"]
        end

        def gpm
          raw["gold_per_min"]
        end

        def xpm
          raw["xp_per_min"]
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
