class SalesOrderDetail < ActiveRecord::Base
  belongs_to :sales_order
  belongs_to :product

  def self.search_details(search)
    if search
      where('sales_order_id = ?',search)
    else
      all
    end
  end
  
end
