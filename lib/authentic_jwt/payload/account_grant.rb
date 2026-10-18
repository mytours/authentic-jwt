# frozen_string_literal: true

module AuthenticJwt
  module Payload
    # One entry of the `account_ids` claim on an agent grant: the account the grant may act on and the
    # region that holds it, so a relying party can route without a directory lookup.
    class AccountGrant < Base
      attr_accessor \
        :id,
        :region

      def initialize(attributes)
        self.id = get_string(attributes, :id)
        self.region = get_string(attributes, :region)
      end

      def self.new_from_raw(raw_attributes)
        raw_attributes.symbolize_keys!
        new(raw_attributes)
      end
    end
  end
end
