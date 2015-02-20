module Dota
  module Utilities
    module Mapped
      def self.included(base)
        base.extend ClassMethods

        base.class_eval do
          def mapping
            self.class.mapping
          end
        end
      end

      module ClassMethods
        def mapping
          @mapping ||= begin
            filename = "#{name.split("::").last.downcase}.yml"
            path = File.join(Dota.root, "data", filename)
            YAML.load_file(path).freeze
          end
        end

        def all
          @all ||= mapping.keys.map { |id| new(id) }
        end
      end
    end
  end
end
