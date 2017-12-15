module ActiveRecord::TableFree
  class Connection
    def quote_table_name(*_args)
      ""
    end
    def quote_column_name(*_args)
      ""
    end
    def substitute_at(*_args)
      nil
    end
    def schema_cache(*_args)
      @_schema_cache ||= ActiveRecord::TableFree::SchemaCache.new
    end
    # Fixes Issue #17. https://github.com/softace/activerecord-tablefree/issues/17
    # The following method is from the ActiveRecord gem: /lib/active_record/connection_adapters/abstract/database_statements.rb .
    # Sanitizes the given LIMIT parameter in order to prevent SQL injection.
    #
    # The +limit+ may be anything that can evaluate to a string via #to_s. It
    # should look like an integer, or a comma-delimited list of integers, or
    # an Arel SQL literal.
    #
    # Returns Integer and Arel::Nodes::SqlLiteral limits as is.
    # Returns the sanitized limit parameter, either as an integer, or as a
    # string which contains a comma-delimited list of integers.
    def sanitize_limit(limit)
      if limit.is_a?(Integer) || limit.is_a?(Arel::Nodes::SqlLiteral)
        limit
      elsif limit.to_s.include?(',')
        Arel.sql limit.to_s.split(',').map{ |i| Integer(i) }.join(',')
      else
        Integer(limit)
      end
    end

    # Called by bound_attributes in /lib/active_record/relation/query_methods.rb
    # Returns a SQL string with the from, join, where, and having clauses, in addition to the limit and offset.
    def combine_bind_parameters(**_args)
      ""
    end

    def lookup_cast_type_from_column(*_args)
      @_cast_type ||= ActiveRecord::TableFree::CastType.new
    end

    # This is used in the StatementCache object. It returns an object that
    # can be used to query the database repeatedly.
    def cacheable_query(arel) # :nodoc:
      if prepared_statements
        ActiveRecord::StatementCache.query visitor, arel.ast
      else
        ActiveRecord::StatementCache.partial_query visitor, arel.ast, collector
      end
    end
  end
end
