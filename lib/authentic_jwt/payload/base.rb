module AuthenticJwt
  module Payload
    class Base
      def get_integer(attributes, name)
        attributes[name] || 0
      end

      def get_string(attributes, name)
        attributes[name] || ""
      end

      def get_array(attributes, name)
        attributes[name] || []
      end

      def get_bool(attributes, name)
        attributes[name] || false
      end
    end
  end
end
