require 'rails'

module WardenLake
  class Engine < ::Rails::Engine
    config.eager_load_paths += Dir["#{config.root}/lib/**/"]
  end
end
