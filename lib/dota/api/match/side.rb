module Dota
  module API
    class Match
      class Side < Entity
        def id
          raw["team_id"]
        end

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
          raw["tower_status"]
        end

        def barracks_status
          raw["barracks_status"]
        end

        def players
          raw["players"].map do |raw_player|
            Player.new(raw_player)
          end
        end

        def captain_id
          raw["captain"]
        end
      end
    end
  end
end
