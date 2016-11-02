json.extract! product_lot, :id, :quantity, :sanitary_registry, :due_date, :lot_number, :production_date, :product_id, :created_at, :updated_at
json.url product_lot_url(product_lot, format: :json)