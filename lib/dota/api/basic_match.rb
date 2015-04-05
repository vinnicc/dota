module Dota
  module API
    class BasicMatch < Entity
      include Utilities::Inspectable

      TYPES = {
        -1 => "Invalid",
        0 => "Public Matchmaking",
        1 => "Practice",
        2 => "Tournament",
        3 => "Tutorial",
        4 => "Co-op with Bots",
        5 => "Team Match",
        6 => "Solo Queue",
        7 => "Ranked"
      }.freeze

      MODES = {
        0 => "None",
        1 => "All Pick",
        2 => "Captain's Mode",
        3 => "Random Draft",
        4 => "Single Draft",
        5 => "All Random",
        6 => "Intro",
        7 => "Diretide",
        8 => "Reverse Captain's Mode",
        9 => "The Greeviling",
        10 => "Tutorial",
        11 => "Mid Only",
        12 => "Least Played",
        13 => "Limited Hero Pool",
        14 => "Compendium Matchmaking",
        15 => "Custom",
        16 => "Captain's Draft",
        17 => "Balanced Draft",
        18 => "Ability Draft",
        19 => "Event",
        20 => "All Random Death Match",
        21 => "1v1 Solo Mid",
        22 => "Ranked All Pick"
      }.freeze

      SKILL_LEVELS = {
        0 => "Any",
        1 => "Normal",
        2 => "High",
        3 => "Very High"
      }.freeze

      def id
        raw["match_id"]
      end
    end
  end
end
