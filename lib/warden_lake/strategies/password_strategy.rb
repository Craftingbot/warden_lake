module WardenLake
  module Strategies
    class PasswordStrategy < ::Warden::Strategies::Base

      def valid?
        identity && password
      end

      def auth_class
        WardenLake.fetch_user_class(scope) || WardenLake.default_user_class
      end

      def authenticate!
        user = auth_class.find_by(WardenLake.identity_field => identity)
        if user && user.authenticate(password)
          success!(user)
        else
          fail!('strategies.authentication_token.failed')
        end
      end

      private
      def password
        sign_in_params['password']
      end

      def identity
        sign_in_params[WardenLake.identity_field.to_s]
      end


      def sign_in_params
        params['sign_in']
      end
    end
  end
end
