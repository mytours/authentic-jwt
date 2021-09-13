# frozen_string_literal: true

require "openssl"
require "jwt"

module AuthenticJwt
  class Validator
    def initialize(public_key: ENV["AUTHENTIC_AUTH_PUBLIC_KEY"])
      raise Unauthorized, "JWT public key not present" if public_key.to_s.empty?

      @public_key = OpenSSL::PKey::RSA.new(public_key.to_s)
    end

    def call(header:)
      raise Unauthorized, "Authorization header missing" if header.to_s.empty?

      bearer_token = extract_bearer_token(header: header)

      extract_payload(bearer_token: bearer_token)
    end

    protected

    BEARER_PATTERN = /Bearer (.+)/.freeze
    ALGORITHM = "RS512"

    attr_reader :public_key

    def extract_bearer_token(header:)
      # rubocop:disable Style/GuardClause
      if header =~ BEARER_PATTERN
        bearer_token = Regexp.last_match(1)
      else
        raise Unauthorized, "Authorization header is not a Bearer token"
      end

      raise Unauthorized, "Bearer token not present" if bearer_token.to_s.empty?

      bearer_token
      # rubocop:enable Style/GuardClause
    end

    def extract_payload(bearer_token:)
      raw_payload, = begin
        JWT.decode(bearer_token, public_key, true, algorithm: ALGORITHM)
      rescue JWT::DecodeError => e
        case e.message
        when /Signature verification raised/
          raise Unauthorized, "JWT does not match signature"
        when /Signature has expired/
          raise Expired, "JWT has expired"
        else
          raise Unauthorized, "Bearer token is not a valid JWT"
        end
      end

      Payload.new_from_raw(raw_payload)
    end
  end
end
