require "authentic_jwt/grape/extension"
require "authentic_jwt/grape/auth_methods"
require "openssl"
require "jwt"

module AuthenticJwt
  module Grape
    class Middleware < ::Grape::Middleware::Base
      def before
        return unless scope

        raise Unauthorized, "JWT public key not present" unless public_key

        raise Unauthorized, "Authorization header not present" unless authorization_header

        raise Unauthorized, "Bearer token not present" unless bearer_token

        raise Unauthorized, "JWT payload not present" unless jwt_payload

        context.extend(AuthMethods)
        context.jwt_payload = jwt_payload

        return unless account_id

        raise Forbidden, "Account has no role" unless account_roles.any?

        raise Forbidden, "Account role is too low" unless (acceptable_roles & account_roles).any?
      end

      protected

      PUBLIC_KEY_ENV_VAR = "AUTHENTIC_AUTH_PUBLIC_KEY".freeze
      ACCOUNT_ID_ENV_VAR = "AUTHENTIC_AUTH_ACCOUNT_ID".freeze
      BEARER_PATTERN     = /Bearer (.+)/

      def context
        env["api.endpoint"]
      end

      def authorization_header
        return if env["HTTP_AUTHORIZATION"].to_s.empty?
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
        return unless authorization_header
        if authorization_header =~ BEARER_PATTERN
          result = Regexp.last_match(1)
          unless result.to_s.empty?
            result
          end
        end
      end

      def public_key
        result = ENV[PUBLIC_KEY_ENV_VAR].to_s
        return if result.empty?
        OpenSSL::PKey::RSA.new(result)
      end

      def jwt_payload
        return unless bearer_token
        return unless public_key
        payload, header = JWT.decode(bearer_token, public_key, true, algorithm: "RS512")
        payload
      end

      def account_id
        result = ENV[ACCOUNT_ID_ENV_VAR].to_s
        return if result.empty?
        result
      end

      def account_payload
        return unless jwt_payload
        jwt_payload["accounts"].detect { |account| account["aud"] == account_id }
      end

      def account_roles
        return [] unless account_payload
        account_payload["roles"].collect(&:downcase)
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
