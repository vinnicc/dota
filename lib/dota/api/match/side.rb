module Dota
  module API
    class Match
      class Side < BasicSide
        def name
          raw["name"]
        end

        def logo_id
          raw["logo"]
        end

        def complete?
          raw["team_complete"] == 1
        end

        def tower_status
          format_status raw["tower_status"], :towers
        end

        def barracks_status
          format_status raw["barracks_status"], :barracks
        end

        def captain_id
          raw["captain"]
        end

        def players
          raw["players"].map do |raw_player|
            Player.new(raw_player)
          end
        end
      end
    end
  end
end