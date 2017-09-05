module AuthenticJwt
  class Unauthorized < RuntimeError; end
  class Forbidden < RuntimeError; end
  class Expired < RuntimeError; end
end
