class PurchaseOrderDocument < ActiveRecord::Base
  belongs_to :purchase_order
  has_attached_file :document
  validates_attachment_content_type :document, :content_type => ["application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain",
             /\Aimage\/.*\Z/]
end
