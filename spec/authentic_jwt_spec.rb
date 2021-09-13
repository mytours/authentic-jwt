# frozen_string_literal: true

require "spec_helper"

describe AuthenticJwt do
  it "has a version number" do
    expect(AuthenticJwt::VERSION).not_to be nil
  end
end
