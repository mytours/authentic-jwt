module AuthenticJwt
  module Role
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

    MAPPING = {
      "subscriber":  10,
      "contributor": 20,
      "author":      30,
      "editor":      40,
      "partner":     70,
      "admin":       80,
      "internal":    90
    }.freeze
  end
end
