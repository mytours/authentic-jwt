module AuthenticJwt
  module Grape
    module AuthMethods
      attr_accessor :jwt_payload

      def jwt_user_id
        return unless jwt_payload
        return unless jwt_payload["id"]
        jwt_payload["id"].to_i
      end
    end
  end
end
