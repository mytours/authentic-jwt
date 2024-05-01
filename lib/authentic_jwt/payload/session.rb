# frozen_string_literal: true

module AuthenticJwt
  module Payload
    class Session < Base
      attr_accessor \
        :sub,
        :exp,
        :iat,
        :username,
        :roles,
        :name,
        :email,
        :interface_language,
        :accounts,
        :partners,
        :external,
        :jwt_token_version,
        :signup_provider,
        :region

      def initialize(attributes)
        self.sub = get_string(attributes, :sub)
        self.exp = get_integer(attributes, :exp)
        self.iat = get_integer(attributes, :iat)
        self.username = get_string(attributes, :username)
        self.roles = get_array(attributes, :roles)
        self.name = get_string(attributes, :name)
        self.email = get_string(attributes, :email)
        self.region = get_string(attributes, :region)
        self.interface_language = get_string(attributes, :interface_language)
        self.accounts = get_array(attributes, :accounts)
        self.partners = get_array(attributes, :partners)
        self.external = get_array(attributes, :external)
        self.jwt_token_version = get_integer(attributes, :jwt_token_version)
        self.signup_provider = get_string(attributes, :signup_provider)
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        raw_attributes[:roles] = (raw_attributes[:roles] || []).map { |r| r.upcase.to_sym }
        raw_attributes[:accounts] = (raw_attributes[:accounts] || []).map { |a| Account.new_from_raw(a) }
        raw_attributes[:partners] = (raw_attributes[:partners] || []).map { |p| Partner.new_from_raw(p) }
        raw_attributes[:external] = (raw_attributes[:external] || []).map { |e| External.new_from_raw(e) }
        new(raw_attributes)
      end
    end
  end
end
