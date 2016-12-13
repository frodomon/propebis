json.extract! invoice, :id, :business_id, :client_id, :sales_order_id, :invoice_number, :date, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)