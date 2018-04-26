module WardenLake
  module Authentication
    extend ActiveSupport::Concern

    included do
      helper_method :authenticated?, :current_user
    end

    def authenticated?(*args)
      warden.authencated?(*args)
    end

    def current_user(*args)
      warden.user(*args)
    end
  end
end
