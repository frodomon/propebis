class PurchaseOrderDetail < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :product

  def self.search_by_id(search)
  	if search
  	  where('purchase_order_id = ?',search)
  	else
  	  all
  	end
  end
end
