module AuthenticJwt
  module Payload
    class Session
      attr_accessor \
        :sub,
        :exp,
        :iat,
        :username,
        :roles,
        :name,
        :email,
        :accounts,
        :partners,
        :external,
        :jwt_token_version

      def initialize(attributes)
        self.sub = attributes[:sub]
        self.exp = attributes[:exp]
        self.iat = attributes[:iat]
        self.username = attributes[:username]
        self.roles = (attributes[:roles] || [])
        self.name = attributes[:name]
        self.email = attributes[:email]
        self.accounts = (attributes[:accounts] || [])
        self.partners = (attributes[:partners] || [])
        self.external = (attributes[:external] || [])
        self.jwt_token_version = attributes[:jwt_token_version]
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        raw_attributes[:roles] = (raw_attributes[:roles] || []).map{|r| r.upcase.to_sym }
        raw_attributes[:accounts] = (raw_attributes[:accounts] || []).map{|a| Account.new_from_raw(a) }
        raw_attributes[:partners] = (raw_attributes[:partners] || []).map{|p| Partner.new_from_raw(p) }
        raw_attributes[:external] = (raw_attributes[:external] || []).map{|e| External.new_from_raw(e) }
        self.new(raw_attributes)
      end
    end
  end
end
