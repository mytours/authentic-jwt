module AuthenticJwt
  module Payload
    class Account
      attr_accessor \
        :aud,
        :roles,
        :name,
        :auto_approve

      def initialize(attributes)
        self.aud = attributes[:aud]
        self.roles = (attributes[:roles] || [])
        self.name = attributes[:name]
        self.auto_approve = attributes[:auto_approve]
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        raw_attributes[:roles] = (raw_attributes[:roles] || []).map{|r| r.upcase.to_sym }
        self.new(raw_attributes)
      end
    end
  end
end
