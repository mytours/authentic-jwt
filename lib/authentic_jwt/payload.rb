require 'authentic_jwt/payload/base'
require 'authentic_jwt/payload/account'
require 'authentic_jwt/payload/external'
require 'authentic_jwt/payload/partner'
require 'authentic_jwt/payload/session'

module AuthenticJwt
  module Payload
    # If an attribute is present that is not recognized, it will be ignored.
    # This is by design so that we can add new attributes and not crash old apps.

    # entry point for manually creating instances, in authentic-auth token creation and tests.
    def self.new(attributes)
      AuthenticJwt::Payload::Session.new(attributes)
    end

    # entry point for raw parsed json from JWT payload
    def self.new_from_raw(raw_attributes)
      AuthenticJwt::Payload::Session.new_from_raw(raw_attributes)
    end
  end
end
