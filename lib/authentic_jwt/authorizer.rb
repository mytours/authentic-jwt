module AuthenticJwt
  class Authorizer
    def initialize(account_id: ENV["AUTHENTIC_AUTH_ACCOUNT_ID"])
      unless account_id.to_s.empty?
        @account_id = account_id.to_s
      end
    end

    attr_reader :account_id

    def call(payload:, scope: nil)
      return unless account_id

      account = payload.accounts.detect { |account| account.aud == account_id }

      unless account
        raise Forbidden, "No access to account"
      end

      roles = account.roles.collect(&:downcase)

      unless roles.any?
        raise Forbidden, "Account has no roles"
      end

      acceptable_roles = calculate_acceptable_roles(scope: scope)

      unless (acceptable_roles & roles).any?
        raise Forbidden, "Account role is too low"
      end

      true
    end

    protected

    def calculate_acceptable_roles(scope:)
      return [] unless scope
        case scope
        when "read"  then AuthenticJwt::Role.read
        when "write" then AuthenticJwt::Role.write
        else raise ArgumentError
      end
    end
  end
end
