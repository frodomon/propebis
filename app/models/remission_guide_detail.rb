class RemissionGuideDetail < ActiveRecord::Base
  belongs_to :remission_guide
  belongs_to :product
end
