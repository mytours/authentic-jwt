# frozen_string_literal: true

require "grape"

module AuthenticJwt
  module Grape
    module Extension
      # `audience:` and `first_party:` are passed to AuthenticJwt::Validator.
      def oauth2(value, **)
        route_setting(:oauth2, scope: value, **)
        value
      end

      ::Grape::API.extend self
    end
  end
end
