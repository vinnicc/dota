module Dota
  module API
    class Match
      class Unit
        attr_reader :name, :items

        def initialize(name, items)
          @name = name.titlecase
          @items = items
        end
      end
    end
  end
end