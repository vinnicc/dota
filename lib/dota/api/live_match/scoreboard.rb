module Dota
  module API
    class LiveMatch
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
          # this maps out much further. for now it'll act as a hash
        def dire
          raw["dire"]
        end
          # this maps out much further. for now it'll act as a hash
      end
    end
  end
end