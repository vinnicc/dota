module Dota
  module API
    class ScheduledMatch < Entity
      def league_id
        raw["league_id"]
      end

      def game_id
        raw["game_id"]
      end

      def teams
        raw["teams"].map do |raw_team|
          raw_team["name"] = raw_team.delete("team_name")
          Team.new(raw_team)
        end
      end

      def starts_at
        Time.at(raw["starttime"])
      end

      def description
        raw["comment"]
      end

      def final?
        raw["final"]
      end
    end
  end
end
