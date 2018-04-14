# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( chosen.min.css )
Rails.application.config.assets.precompile += %w( chosen.jquery.min.js )
Rails.application.config.assets.precompile += %w( chosen-sprite.png )
Rails.application.config.assets.precompile += %w( chosen-sprite@2x.png )
Rails.application.config.assets.precompile += %w( bootstrap-datepicker.js )
Rails.application.config.assets.precompile += %w( datepicker3.css )
Rails.application.config.assets.precompile += %w( bootstrap3-wysihtml5.all.min.js )
Rails.application.config.assets.precompile += %w( bootstrap3-wysihtml5.min.css )
Rails.application.config.assets.precompile += %w( bootstrap-datetimepicker.js )
Rails.application.config.assets.precompile += %w( bootstrap-datetimepicker.css )
