module WardenLake
  class Manager
    def self.new(app, opts={}, &block)
      if scope_mapping = opts.delete(:scope_mapping)
        WardenLake.scope_mapping = scope_mapping
        puts WardenLake.scope_mapping
      end

      if default_scope = opts.delete(:default_scope)
        WardenLake.default_user_class = WardenLake.scope_mapping[default_scope]
        puts WardenLake.default_user_class
      end
      Warden::Manager.new(app, opts, &block)
    end
  end
end
