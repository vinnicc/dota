module Dota
  module API
    class LiveMatch
      class Side < Entity
        def id
          raw["team_id"]
        end

        def name
          raw["team_name"]
        end

        def logo_id
          raw["team_logo"]
        end

        def complete?
          raw["complete"]
        end

        def tower_status
          raw["tower_state"]
        end

        def barracks_status
          raw["barracks_state"]
        end

        def series_wins
          raw["series_wins"]
        end

        def players
          raw["players"].map do |raw_player|
            Player.new(raw_player)
          end
        end

        def score
          raw["score"]
        end
      end
    end
  end
end
