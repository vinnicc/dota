module Dota
  module API
    class LiveLeague
      class Scoreboard
        include Utilities::Inspectable

        attr_reader :raw

        def initialize(raw)
          @raw = raw
        end

        def duration
          raw["duration"]
        end
        def roshan_timer
          raw["roshan_respawn_timer"]
        end
        def radiant
          raw["radiant"]
        end
        def dire
          raw["dire"]
        end
      end
    end
  end
end