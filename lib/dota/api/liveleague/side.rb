module Dota
  module API
    class LiveLeague
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

        def logo
          raw["team_logo"]
        end

        def complete
          raw["complete"]
        end
      end
      class Radiant < Side

      end
      class Dire < Side   

      end 
    end    
  end
end
