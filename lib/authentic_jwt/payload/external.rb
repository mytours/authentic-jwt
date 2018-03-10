module AuthenticJwt
  module Payload
    class External
      attr_accessor \
        :iss,
        :access_token,
        :refresh_token,
        :secret

      def initialize(attributes)
        self.iss = attributes[:iss]
        self.access_token = attributes[:access_token]
        self.refresh_token = attributes[:refresh_token]
        self.secret = attributes[:secret]
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        self.new(raw_attributes)
      end
    end
  end
end
