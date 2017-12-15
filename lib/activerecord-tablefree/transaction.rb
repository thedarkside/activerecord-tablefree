module ActiveRecord::TableFree
  class Transaction < ActiveRecord::ConnectionAdapters::NullTransaction
  end
end
