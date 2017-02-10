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
  def self.search_details_rg(search)
    if search
      where('sales_order_id = ? and pending_rg > 0',search)
    else
      all
    end
  end
  def self.search_details_cg(search)
    if search
      where('sales_order_id = ? and pending_cg > 0',search)
    else
      all
    end
  end
  def self.search_details_inv(search)
    if search
      where('sales_order_id = ? and pending_inv > 0',search)
    else
      all
    end
  end
end
