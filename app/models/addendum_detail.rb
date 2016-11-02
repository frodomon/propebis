class AddendumDetail < ActiveRecord::Base
  belongs_to :addendum
  belongs_to :product
end
