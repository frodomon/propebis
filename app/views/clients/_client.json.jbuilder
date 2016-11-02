json.extract! client, :id, :name, :ruc, :billing_address, :delivery_address, :telephone, :contact, :active, :created_at, :updated_at
json.url client_url(client, format: :json)