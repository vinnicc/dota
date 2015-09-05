module Dota
  module API
    class Item
      include Utilities::Mapped

      attr_reader :id, :name

      def initialize(id)
        @id = id
        @internal_name = mapping[id][0]
        @name = mapping[id][1]
      end

      def image_url(type = :lg)
        # Possible values for type:
        # :lg - 85x64 PNG image
        # :eg - 27x20 PNG image
        if internal_name =~ /\Arecipe/
          "http://cdn.dota2.com/apps/dota2/images/items/#{internal_name.sub('recipe_', '')}_#{type}.png"
        else
          "http://cdn.dota2.com/apps/dota2/images/items/#{internal_name}_#{type}.png"
        end
      end

      private

      attr_reader :internal_name
    end
  end
end
