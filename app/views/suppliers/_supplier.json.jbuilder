json.extract! supplier, :id, :name, :ruc, :address, :telephone, :contact, :active, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)