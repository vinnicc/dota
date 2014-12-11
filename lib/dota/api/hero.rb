module Dota
  module API
    class Hero
      MAPPING = YAML.load_file("data/heroes.yml").freeze

      attr_reader :id, :name

      def self.all
        @all ||= MAPPING.keys.map { |id| new(id) }
      end

      def initialize(id)
        @id = id
        @internal_name = MAPPING[id][0]
        @name = MAPPING[id][1]
      end

      def image_url(type = :full)
        "http://cdn.dota2.com/apps/dota2/images/heroes/#{internal_name}_#{type}.png"
      end

      private

      attr_reader :internal_name
    end
  end
end
