class RemissionGuide < ActiveRecord::Base
  belongs_to :business
  belongs_to :client
  belongs_to :driver
  belongs_to :vehicle
  has_many :remission_guide_details, dependent: :destroy
  accepts_nested_attributes_for :remission_guide_details, allow_destroy: true

  def self.search_details(search)
    if search
      where('sales_order_id = ?',search)
    else
      all
    end
  end
end
