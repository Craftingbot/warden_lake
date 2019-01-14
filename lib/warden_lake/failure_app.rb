require "action_controller/metal"

module WardenLake
  class FailureApp < ActionController::Metal
    include ActionController::UrlFor
    include ActionController::Redirecting

    include Rails.application.routes.url_helpers
    include Rails.application.routes.mounted_helpers

     delegate :flash, to: :request

     def self.call(env)
       @respond ||= action(:respond)
       @respond.call(env)
     end

     def respond
       if auth_fallback.blank?
         self.status = 401
         self.headers["WWW-Authenticate"] = %(Basic realm=realm) 
         self.content_type = request.format.to_s
       else
         controller, action = auth_fallback.split("#")
         controller_name  = ActiveSupport::Inflector.camelize(controller)
         controller_klass = ActiveSupport::Inflector.constantize("#{controller_name}Controller")
         self.response = controller_klass.action(action).call(request.env)
       end
     end

     def auth_fallback
       request.env["warden.options"][:fallback]
     end
  end
end
