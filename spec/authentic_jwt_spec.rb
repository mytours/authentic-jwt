# frozen_string_literal: true

require "spec_helper"

describe AuthenticJwt do
  it "has a version number" do
    expect(AuthenticJwt::VERSION).not_to be nil
  end

  it "retunrs the roles as a sym" do
    expect(AuthenticJwt::Role.enum_sym).to eq(
      {
        subscriber: 10,
        contributor: 20,
        author: 30,
        editor: 40,
        partner: 70,
        admin: 80,
        internal: 90
      }
    )
  end
end
