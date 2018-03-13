module AuthenticJwt
  module Payload
    class Account < Base
      attr_accessor \
        :aud,
        :roles,
        :name,
        :auto_approve,
        :child_accounts

      def initialize(attributes)
        self.aud = get_string(attributes, :aud)
        self.roles = get_array(attributes, :roles)
        self.name = get_string(attributes, :name)
        self.auto_approve = get_bool(attributes, :auto_approve)
        self.child_accounts = get_array(attributes, :child_accounts)
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        raw_attributes[:roles] = (raw_attributes[:roles] || []).map{|r| r.upcase.to_sym }
        raw_attributes[:child_accounts] = (raw_attributes[:child_accounts] || []).map{|a| Account.new_from_raw(a) }
        self.new(raw_attributes)
      end
    end
  end
end
