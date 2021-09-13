# frozen_string_literal: true

module AuthenticJwt
  class Authorizer
    def initialize(account_id: ENV["AUTHENTIC_AUTH_ACCOUNT_ID"])
      @account_id = account_id.to_s unless account_id.to_s.empty?
    end

    attr_reader :account_id

    def call(payload:, scope: nil)
      return unless account_id

      account = payload.accounts.detect { |a| a.aud == account_id }

      raise Forbidden, "No access to account" unless account

      roles = account.roles.collect(&:to_s).collect(&:downcase)

      raise Forbidden, "Account has no roles" unless roles.any?

      acceptable_roles = calculate_acceptable_roles(scope: scope)

      raise Forbidden, "Account role is too low" unless (acceptable_roles & roles).any?

      true
    end

    protected

    def calculate_acceptable_roles(scope:)
      return [] unless scope

      case scope
      when "read"  then AuthenticJwt::Role.read
      when "write" then AuthenticJwt::Role.write
      when "admin" then AuthenticJwt::Role.admin
      else raise ArgumentError
      end
    end
  end
end
