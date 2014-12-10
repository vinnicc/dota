module Dota
  module API
    class Entity
      include Utilities::Inspectable

      attr_reader :raw

      def initialize(raw)
        @raw = raw
      end
    end
  end
end
