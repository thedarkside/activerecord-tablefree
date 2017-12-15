module ActiveRecord::Tablefree
  class Transaction < ActiveRecord::ConnectionAdapters::NullTransaction
  end
end
