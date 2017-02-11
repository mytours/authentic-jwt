require "authentic_jwt/grape/extension"
require "authentic_jwt/grape/auth_methods"

module AuthenticJwt
  module Grape
    class Middleware < ::Grape::Middleware::Base
      def before
        return unless scope

        validator = AuthenticJwt::Validator.new
        payload = validator.call(header: header)

        authorizer = AuthenticJwt::Authorizer.new
        authorizer.call(payload: payload, scope: scope)

        context.extend(AuthMethods)
        context.jwt_payload = payload
      end

      protected

      def header
        env["HTTP_AUTHORIZATION"]
      end

      def context
        env["api.endpoint"]
      end

      def route_setting
        context.route_setting(:oauth2)
      end

      def scope
        return unless route_setting
        route_setting.fetch(:scope, nil)
      end
    end
  end
end
