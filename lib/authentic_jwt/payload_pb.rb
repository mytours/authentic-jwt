# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: payload.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "AuthenticJwt.Payload" do
    optional :sub, :string, 2
    optional :exp, :int32, 4
    optional :iat, :int32, 6
    optional :username, :string, 9
    repeated :roles, :enum, 10, "AuthenticJwt.Payload.Role"
    optional :name, :string, 11
    optional :email, :string, 12
    repeated :partners, :message, 13, "AuthenticJwt.Payload.Partner"
    repeated :accounts, :message, 14, "AuthenticJwt.Payload.Account"
    repeated :external, :message, 15, "AuthenticJwt.Payload.External"
    optional :jwt_token_version, :int32, 16
  end
  add_message "AuthenticJwt.Payload.Partner" do
    optional :aud, :string, 3
    repeated :roles, :enum, 10, "AuthenticJwt.Payload.Role"
  end
  add_message "AuthenticJwt.Payload.Account" do
    optional :aud, :string, 3
    repeated :roles, :enum, 10, "AuthenticJwt.Payload.Role"
    optional :name, :string, 11
    optional :auto_approve, :bool, 12
  end
  add_message "AuthenticJwt.Payload.External" do
    optional :iss, :string, 1
    optional :access_token, :string, 11
    optional :refresh_token, :string, 12
    optional :secret, :string, 13
  end
  add_enum "AuthenticJwt.Payload.Role" do
    value :UNSUBSCRIBED, 0
    value :SUBSCRIBER, 10
    value :CONTRIBUTOR, 20
    value :AUTHOR, 30
    value :EDITOR, 40
    value :PARTNER, 70
    value :ADMIN, 80
    value :INTERNAL, 90
  end
end

module AuthenticJwt
  Payload = Google::Protobuf::DescriptorPool.generated_pool.lookup("AuthenticJwt.Payload").msgclass
  Payload::Partner = Google::Protobuf::DescriptorPool.generated_pool.lookup("AuthenticJwt.Payload.Partner").msgclass
  Payload::Account = Google::Protobuf::DescriptorPool.generated_pool.lookup("AuthenticJwt.Payload.Account").msgclass
  Payload::External = Google::Protobuf::DescriptorPool.generated_pool.lookup("AuthenticJwt.Payload.External").msgclass
  Payload::Role = Google::Protobuf::DescriptorPool.generated_pool.lookup("AuthenticJwt.Payload.Role").enummodule
end
