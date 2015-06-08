module Dota
  module API
    class BasicPlayer < Entity
      include Utilities::Inspectable

      TYPES = {
        0 => :radiant,
        1 => :dire,
        2 => :broadcaster,
        4 => :unassigned
      }

      STATUS = {
        0 => :played,
        1 => :left_safe,
        2 => :disconnected,
        3 => :abandoned,
        4 => :afk,
        5 => :never_connected,
        6 => :timed_out
      }

      def id
        raw["account_id"]
      end

      def hero
        Hero.find(raw["hero_id"])
      end

      def level
        raw["level"]
      end

      def assists
        raw["assists"]
      end

      def last_hits
        raw["last_hits"]
      end

      def denies
        raw["denies"]
      end

      def gold
        raw["gold"]
      end

      def kills
        raw["kills"]
      end

      def gpm
        raw["gold_per_min"]
      end

      def xpm
        raw["xp_per_min"]
      end
    end
  end
end
