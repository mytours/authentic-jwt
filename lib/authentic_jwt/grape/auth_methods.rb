module AuthenticJwt
  module Grape
    module AuthMethods
      attr_accessor :jwt_payload

      def jwt_sub
        return unless jwt_payload
        jwt_payload.sub
      end
    end
  end
end
