task :build_definitions do
  `protoc --ruby_out=lib/authentic_jwt -I definitions definitions/payload.proto`
end
