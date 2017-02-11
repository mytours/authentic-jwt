require "spec_helper"

describe AuthenticJwt::Authorizer do
  subject(:authorizer) { AuthenticJwt::Authorizer.new }

  let(:no_accounts_payload) do
    AuthenticJwt::Payload.new({
      sub:   "1",
      name:  "Isabelle Kermode",
      email: "isabellekermode@example.com",
      roles: [:SUBSCRIBER]
    })
  end

  let(:no_roles_payload) do
    AuthenticJwt::Payload.new({
      sub:      "2",
      name:     "Aiden Twopeny",
      email:    "aidentwopeny@example.com",
      roles:    [:SUBSCRIBER],
      accounts: [
        AuthenticJwt::Payload::Account.new({
          aud:   ENV["AUTHENTIC_AUTH_ACCOUNT_ID"],
          roles: [],
        })
      ]
    })
  end

  let(:insufficient_payload) do
    AuthenticJwt::Payload.new({
      sub:      "3",
      name:     "Charlotte Cumbrae",
      email:    "charlottecumbrae@example.com",
      roles:    [:SUBSCRIBER],
      accounts: [
        AuthenticJwt::Payload::Account.new({
          aud:   ENV["AUTHENTIC_AUTH_ACCOUNT_ID"],
          roles: [:SUBSCRIBER],
        })
      ]
    })
  end

  let(:valid_payload) do
    AuthenticJwt::Payload.new({
      sub:      "4",
      name:     "Jade Uther",
      email:    "jadeuther@example.com",
      roles:    [:SUBSCRIBER],
      accounts: [
        AuthenticJwt::Payload::Account.new({
          aud:   ENV["AUTHENTIC_AUTH_ACCOUNT_ID"],
          roles: [:ADMIN],
        })
      ]
    })
  end

  it "returns forbidden if the payload doesn't have access to the account" do
    expect { authorizer.call(payload: no_accounts_payload, scope: "write") }.to raise_error(AuthenticJwt::Forbidden, "No access to account")
  end

  it "returns forbidden if the payload account has no roles" do
    expect { authorizer.call(payload: no_roles_payload, scope: "write") }.to raise_error(AuthenticJwt::Forbidden, "Account has no roles")
  end

  it "returns forbidden if the payload account doesn't have sufficient access" do
    expect { authorizer.call(payload: insufficient_payload, scope: "write") }.to raise_error(AuthenticJwt::Forbidden, "Account role is too low")
  end

  it "returns true if the payload is ok" do
    expect(authorizer.call(payload: valid_payload, scope: "write")).to eq(true)
  end
end
