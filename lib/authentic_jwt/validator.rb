require "openssl"
require "jwt"

module AuthenticJwt
  class Validator
    def initialize(public_key: ENV["AUTHENTIC_AUTH_PUBLIC_KEY"])
      if public_key.to_s.empty?
        raise Unauthorized, "JWT public key not present"
      end

      @public_key = OpenSSL::PKey::RSA.new(public_key.to_s)
    end

    def call(header:)
      if header.to_s.empty?
        raise Unauthorized, "Authorization header missing"
      end

      bearer_token = extract_bearer_token(header: header)

      extract_payload(bearer_token: bearer_token)
    end

    protected

    BEARER_PATTERN = /Bearer (.+)/
    ALGORITHM = "RS512"

    attr_reader :public_key

    def extract_bearer_token(header:)
      if header =~ BEARER_PATTERN
        bearer_token = Regexp.last_match(1)
      else
        raise Unauthorized, "Authorization header is not a Bearer token"
      end

      if bearer_token.to_s.empty?
        raise Unauthorized, "Bearer token not present"
      end

      bearer_token
    end

    def extract_payload(bearer_token:)
      raw, header = begin
        JWT.decode(bearer_token, public_key, true, algorithm: ALGORITHM)
      rescue JWT::DecodeError => error
        if error.message =~ /Signature verification raised/
          raise Unauthorized, "JWT does not match signature"
        elsif error.message =~ /Signature has expired/
          raise Expired, "JWT has expired"
        else
          raise Unauthorized, "Bearer token is not a valid JWT"
        end
      end

      # TODO: bypass this step
      json = JSON.dump(raw)

      begin
        Payload.decode_json(json)
      rescue Google::Protobuf::ParseError
        raise Unauthorized, "JWT is not in the correct format"
      end
    end
  end
end
