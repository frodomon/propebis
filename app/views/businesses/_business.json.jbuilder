json.extract! business, :id, :name, :ruc, :billing_address, :delivery_address, :telephone, :contact, :active, :created_at, :updated_at
json.url business_url(business, format: :json)