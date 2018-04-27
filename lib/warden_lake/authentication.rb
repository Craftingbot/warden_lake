module WardenLake
  module Authentication
    extend ActiveSupport::Concern

    included do
      helper_method :authenticated?, :user_hash
    end

    def authenticated?(*args)
      warden.authencated?(*args)
    end

    def user_values(*args)
      warden.user(*args)
    end

    def warden
      request.env['warden']
    end
  end
end
