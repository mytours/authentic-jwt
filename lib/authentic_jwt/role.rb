module AuthenticJwt
  module Role
    def self.roles
      MAPPING.keys
    end

    def self.enum
      MAPPING
    end

    def self.read
      READ + WRITE + ADMIN
    end

    def self.write
      WRITE + ADMIN
    end

    def self.admin
      ADMIN
    end

    protected

    READ  = ["subscriber"].freeze
    WRITE = ["contributor", "author", "editor", "partner"].freeze
    ADMIN = ["admin", "internal"].freeze

    MAPPING = {
      "subscriber"  => 10,
      "contributor" => 20,
      "author"      => 30,
      "editor"      => 40,
      "partner"     => 70,
      "admin"       => 80,
      "internal"    => 90
    }.freeze
  end
end
