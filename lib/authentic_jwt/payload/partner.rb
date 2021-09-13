# frozen_string_literal: true

module AuthenticJwt
  module Payload
    class Partner < Base
      attr_accessor \
        :aud,
        :roles

      def initialize(attributes)
        self.aud = get_string(attributes, :aud)
        self.roles = get_array(attributes, :roles)
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        raw_attributes[:roles] = (raw_attributes[:roles] || []).map { |r| r.upcase.to_sym }
        new(raw_attributes)
      end
    end
  end
end
