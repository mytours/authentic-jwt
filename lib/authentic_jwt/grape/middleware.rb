require "authentic_jwt/grape/extension"
require "openssl"
require "jwt"

module AuthenticJwt
  module Grape
    module AuthMethods
      attr_accessor :jwt_payload

      def current_user_id
        return unless jwt_payload
        jwt_payload["id"]
      end
    end

    class Middleware < ::Grape::Middleware::Base
      def before
        return unless scope

        raise Unauthorized unless jwt_payload

        context.extend(AuthMethods)
        context.jwt_payload = jwt_payload

        return unless account_id

        raise Forbidden unless account_role

        raise Forbidden unless acceptable_roles.include?(account_role)
      end

      protected

      PUBLIC_KEY_ENV_VAR = "AUTHENTIC_AUTH_PUBLIC_KEY".freeze
      BEARER_PATTERN     = /Bearer (.+)/

      ACCOUNT_ID_ENV_VAR = "AUTHENTIC_AUTH_ACCOUNT_ID".freeze

      def context
        env["api.endpoint"]
      end

      def authorization
        env["HTTP_AUTHORIZATION"]
      end

      def route_setting
        context.route_setting(:oauth2)
      end

      def scope
        return unless route_setting
        route_setting.fetch(:scope, nil)
      end

      def bearer_token
        return unless authorization
        Regexp.last_match(1) if authorization =~ BEARER_PATTERN
      end

      def public_key
        return unless ENV[PUBLIC_KEY_ENV_VAR]
        OpenSSL::PKey::RSA.new(ENV[PUBLIC_KEY_ENV_VAR])
      end

      def jwt_payload
        return unless bearer_token
        payload, header = JWT.decode(bearer_token, public_key, true, algorithm: "RS512")
        payload
      end

      def account_id
        return unless ENV[ACCOUNT_ID_ENV_VAR]
        ENV[ACCOUNT_ID_ENV_VAR].to_i
      end

      def account_payload
        return unless jwt_payload
        jwt_payload["accounts"].detect { |account| account["id"] == account_id }
      end

      def account_role
        return unless account_payload
        account_payload["role"]
      end

      def acceptable_roles
        return [] unless scope
        case scope
        when "read"  then AuthenticJwt::Role.read
        when "write" then AuthenticJwt::Role.write
        else raise ArgumentError
        end
      end
    end
  end
end
