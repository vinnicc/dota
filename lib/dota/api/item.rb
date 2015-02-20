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
        "http://cdn.dota2.com/apps/dota2/images/items/#{internal_name}_#{type}.png"
      end

      private

      attr_reader :internal_name
    end
  end
end
