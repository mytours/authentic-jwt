module AuthenticJwt
  module Role
    def self.roles
      MAPPING.keys
    end

    def self.mapping
      MAPPING
    end

    def self.read
      READ + WRITE
    end

    def self.write
      WRITE
    end

    protected

    READ  = ["subscriber"].freeze
    WRITE = ["contributor", "author", "editor", "partner", "admin", "internal"].freeze

    MAPPING = AuthenticJwt::Payload::Role.constants.inject({}) do |memo, const|
      memo[const.to_s.downcase] = AuthenticJwt::Payload::Role.const_get(const)
      memo
    end.freeze
  end
end
