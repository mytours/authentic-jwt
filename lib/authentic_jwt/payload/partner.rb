module AuthenticJwt
  module Payload
    class Partner
      attr_accessor \
        :aud,
        :roles

      def initialize(attributes)
        self.aud = attributes[:aud]
        self.roles = (attributes[:roles] || [])
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        raw_attributes[:roles] = (raw_attributes[:roles] || []).map{|r| r.upcase.to_sym }
        self.new(raw_attributes)
      end
    end
  end
end
