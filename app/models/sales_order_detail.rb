class SalesOrderDetail < ActiveRecord::Base
  belongs_to :sales_order
  belongs_to :product
end
