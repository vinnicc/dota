module Dota
  module API
    class Ability
      include Utilities::Mapped

      attr_reader :id, :name, :full_name

      alias_method :full_name, :name

      def initialize(id)
        @id = id
        @internal_name = mapping[id][0]
        @name = mapping[id][1] || @internal_name
      end

      def image_url(type = :lg)
        # Possible values for type:
        # :hp1 - 90x90 PNG image
        # :hp2 - 105x105 PNG image
        # :lg - 128x128 PNG image

        "http://cdn.dota2.com/apps/dota2/images/abilities/#{internal_name}_#{type}.png"
      end

      private

      attr_reader :internal_name
    end
  end
end
