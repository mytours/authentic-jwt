# frozen_string_literal: true

require "spec_helper"

describe AuthenticJwt::Payload do
  let(:agent_claims) do
    {
      "jti" => "a1", "sub" => "1907", "exp" => 1, "region" => "us",
      "scope" => "read write", "aud" => "https://mcp.stqry.com/mcp",
      "account_ids" => [{ "id" => "1776", "region" => "ca" }, { "id" => "1", "region" => "us" }]
    }
  end

  it "exposes the agent grant claims" do
    payload = described_class.new_from_raw(agent_claims)

    expect(payload.scope).to eq("read write")
    expect(payload.scopes).to eq(%w[read write])
    expect(payload.aud).to eq("https://mcp.stqry.com/mcp")
    expect(payload.account_ids.map(&:id)).to eq(%w[1776 1])
    expect(payload.account_ids.map(&:region)).to eq(%w[ca us])
    expect(payload.account_ids.first).to be_a(AuthenticJwt::Payload::AccountGrant)
  end

  it "leaves the agent grant claims blank on a first-party token" do
    payload = described_class.new_from_raw({ "jti" => "a1", "sub" => "1907" })

    expect(payload.scope).to eq("")
    expect(payload.scopes).to eq([])
    expect(payload.aud).to eq("")
    expect(payload.account_ids).to eq([])
  end

  it "serialises the grant entries" do
    payload = described_class.new_from_raw(agent_claims)

    expect(payload.as_json["account_ids"]).to eq([{ "id" => "1776", "region" => "ca" }, { "id" => "1", "region" => "us" }])
  end
end
