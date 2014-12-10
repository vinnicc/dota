module Dota
  module API
    class LiveMatch
      class Side
        include Utilities::Inspectable

        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def name
          raw["team_name"]
        end

        def id
          raw["team_id"]
        end

        def logo_id
          raw["team_logo"]
        end

        def complete?
          raw["complete"]
        end

        def score
          raw["score"]
        end

        def tower_status
          raw["tower_state"]
        end

        def barracks_status
          raw["barracks_state"]
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
