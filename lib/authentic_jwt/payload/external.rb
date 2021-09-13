# frozen_string_literal: true

module AuthenticJwt
  module Payload
    class External < Base
      attr_accessor \
        :iss,
        :access_token,
        :refresh_token,
        :secret

      def initialize(attributes)
        self.iss = get_string(attributes, :iss)
        self.access_token = get_string(attributes, :access_token)
        self.refresh_token = get_string(attributes, :refresh_token)
        self.secret = get_string(attributes, :secret)
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        new(raw_attributes)
      end
    end
  end
end
