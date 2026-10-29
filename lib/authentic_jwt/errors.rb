# frozen_string_literal: true

module AuthenticJwt
  class Unauthorized < RuntimeError; end

  # An Unauthorized, so a caller that rescues Unauthorized already refuses it.
  class WrongAudience < Unauthorized; end

  class Forbidden < RuntimeError; end

  class Expired < RuntimeError; end
end
