module Dota
  module API
    class Item
      MAPPING = YAML.load_file("data/items.yml").freeze

      attr_reader :id, :name

      def self.all
        MAPPING.keys.map { |id| new(id) }
      end

      def initialize(id)
        @id = id
        @internal_name = MAPPING[id][0]
        @name = MAPPING[id][1]
      end

      def image_url(type = :lg)
        "http://cdn.dota2.com/apps/dota2/images/items/#{internal_name}_#{type}.png"
      end

      private

      attr_reader :internal_name
    end
  end
end
