require "spec_helper"

describe AuthenticJwt::Authorizer do
  subject(:authorizer) { AuthenticJwt::Authorizer.new }

  let(:no_accounts_payload) do
    AuthenticJwt::Payload.new({
      sub:      "1",
      name:     "Isabelle Kermode",
      email:    "isabellekermode@example.com",
      username: "isabellekermode",
      roles:    [:SUBSCRIBER]
    })
  end

  let(:no_roles_payload) do
    AuthenticJwt::Payload.new({
      sub:      "2",
      name:     "Aiden Twopeny",
      email:    "aidentwopeny@example.com",
      username: "aidentwopeny",
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
      username: "charlottecumbrae",
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
      username: "jadeuther",
      roles:    [:SUBSCRIBER],
      accounts: [
        AuthenticJwt::Payload::Account.new({
          aud:   ENV["AUTHENTIC_AUTH_ACCOUNT_ID"],
          roles: [:ADMIN],
        })
      ]
    })
  end

  let(:editor_payload) do
    AuthenticJwt::Payload.new({
      sub:      "5",
      name:     "Frodo Baggins",
      email:    "frodo@example.com",
      username: "frodo",
      roles:    [:SUBSCRIBER],
      accounts: [
        AuthenticJwt::Payload::Account.new({
          aud:   ENV["AUTHENTIC_AUTH_ACCOUNT_ID"],
          roles: [:EDITOR],
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

  it "returns forbidden if the payload account doesn't have admin access" do
    expect { authorizer.call(payload: editor_payload, scope: "admin") }.to raise_error(AuthenticJwt::Forbidden, "Account role is too low")
  end

  it "returns true if the payload is ok" do
    expect(authorizer.call(payload: valid_payload, scope: "write")).to eq(true)
  end
end
