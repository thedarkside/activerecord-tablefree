module ActiveRecord::Tablefree
  class StatementCache < ActiveRecord::StatementCache
    def self.create(*_args)
      new Object.new, ActiveRecord::Tablefree::StatementCache::BindMap.new
    end

    def execute
      nil
    end

    class BindMap
      def initialize(*_args)
        @indexes = []
        @bound_attributes = []
      end

      def bind(*_args)
        []
      end
    end
  end
end
