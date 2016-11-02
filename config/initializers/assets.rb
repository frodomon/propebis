# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

#Ordenes de Compra
Rails.application.config.assets.precompile += %w( purchase_orders.js )
Rails.application.config.assets.precompile += %w( purchase_orders.css )
#Lotes de Producto
Rails.application.config.assets.precompile += %w( product_lots.js )
#Contratos
Rails.application.config.assets.precompile += %w( contracts.js )
Rails.application.config.assets.precompile += %w( addendums.js )
#Ordenes de Venta
Rails.application.config.assets.precompile += %w( sales_orders.js )
Rails.application.config.assets.precompile += %w( sales_orders.css )
#Guias de Remisión
Rails.application.config.assets.precompile += %w( remission_guides.js )
Rails.application.config.assets.precompile += %w( remission_guides.css )