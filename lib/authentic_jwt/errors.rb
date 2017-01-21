module AuthenticJwt
  class Unauthorized < RuntimeError; end
  class Forbidden < RuntimeError; end
end
