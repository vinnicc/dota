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
          0 => "Played",
          1 => "Left Safely",
          2 => "Abandoned (DC)",
          3 => "Abandoned",
          4 => "Abandoned (AFK)",
          5 => "Never Connected",
          6 => "Never Connected (Timeout)"
      }

      def id
        raw["account_id"]
      end

      def hero
        Hero.new(raw["hero_id"])
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
