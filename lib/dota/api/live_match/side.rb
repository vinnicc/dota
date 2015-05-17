module Dota
  module API
    class LiveMatch
      class Side < BasicSide
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
          format_status raw["tower_state"], :towers
        end

        def barracks_status
          format_status raw["barracks_state"], :barracks
        end

        def series_wins
          raw["series_wins"]
        end

        def score
          raw["score"]
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
