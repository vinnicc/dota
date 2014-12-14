module Dota
  module API
    class ScheduleMatch < Entity
      def league_id
        raw["league_id"]
      end

      def game_id
        raw["game_id"]
      end

      def teams
        raw["teams"].map do |raw_team|
          Team.new(raw_team)
        end
      end

      def start_time
        raw["starttime"]
      end

      def comment
        raw["comment"]
      end

      def final?
        raw["final"]
      end
    end
  end
end