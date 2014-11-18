module Dota
  module API
    class Match
      class Player
        def initialize(raw)
          @raw = raw
        end

        def id
          raw["account_id"]
        end

        def slot
          raw["player_slot"]
        end

        def status
          case raw["leaver_status"]
          when 0
            :played
          when 1
            :left_safe
          when 2
            :abandoned
          else
            :bot
          end
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
          raw["deaths"]
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

        def gold
          raw["gold"]
        end

        def gold_spent
          raw["gold_spent"]
        end

        def gpm
          raw["gold_per_min"]
        end

        def xpm
          raw["xp_per_min"]
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

        private

        attr_reader :raw
      end
    end
  end
end
