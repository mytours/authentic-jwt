# frozen_string_literal: true

require "spec_helper"

describe AuthenticJwt::Validator do
  subject(:validator) { AuthenticJwt::Validator.new }

  let(:valid_jwt) { "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzUxMiJ9.eyJqdGkiOiI2MDk1ZDFjOC00MDM0LTQ2NDctYTFjMS03NmUxYjI0NDgyZmMiLCJzdWIiOiIxOTA3Iiwicm9sZXMiOlsiQURNSU4iXSwibmFtZSI6IlN0ZXZlIEhvZWtzZW1hIiwiZW1haWwiOiJteXRvdXJzQGtvdGlyaS5jb20iLCJyZWdpb24iOiJjYSIsInBhcnRuZXJzIjpbeyJhdWQiOiJteXRvdXJzIiwicm9sZXMiOlsiQURNSU4iXX1dLCJhY2NvdW50cyI6W3siYXVkIjoiMTc3NiIsInJlZ2lvbiI6ImNhIiwicm9sZXMiOlsiQURNSU4iXX0seyJhdWQiOiIxIiwicmVnaW9uIjoiY2EiLCJyb2xlcyI6WyJBRE1JTiJdfV0sImV4dGVybmFsIjpbeyJpc3MiOiJnb29nbGUiLCJhY2Nlc3NfdG9rZW4iOiJ5YTI5LkdsdnFBOFdrcTczRXJiUGxfSTVXZVRndnI5bk1QRGY5WTliRzNpeVpXaUI4dnVVSkZmckJvVTZ4V0pLTV9fYXR0ZDlDcFd1QkdYQ1BsRXRnUVgtdU9kdDZSWGEwWTU3Q1RRQTZXT2JMdDFMamMxd1pDeDNHT2FQejhrLWUiLCJyZWZyZXNoX3Rva2VuIjoiMS9FSktDakxrX2ZzNzZqZ3JLUUJVRUMwZ0ZQdU94a1I3bmk3dV9uUXFnN3ZrIn1dfQ.U226gaeqdF-iF7Zv__9wXpoeKAVvCvI3vrmYeD1Oj6k1cZdfM_smqc-wq5bZrYhXauOs96oGi0TW1eS1YTHeENf6PavxEYExcLG4D1wbdNJ0qILP0p2pHHwdDdy5HCAGBs5OihVC6XEfJBZi2xBV-o_u1Ukb7FEJaXWS-LHITI1OfUAaRne9qxDVxOZ3ZuT6JtO0yvgKM3e00W1Mec1K6xbSqRsky_21xrAz7C7u3MNwANjs9T9YfHhHcpKqQUrkQsQvgbMT9GpRqt75VYjtUncFvdRuGU4G3VB9Z1PnOBsWOi8xmVhrYAfLBvqg3uG9uh72ONHMrHubUlfUr6Rzl6T9Jrd1Bd1Tf38-2ELwWAYQsmKYAyZJcRqX1mvZ2EmJInCgB8LIcnPdJZN8RHb200UMAKbwaf_ZkkcFI2XGaVdk2dUYjzwbLxDblUtCD10a2FhUkzVJfzunG9GAReL_GxyAqbzrhnqYHRzcwd_tvyP5pbqk5_08MKfISWztuMDjG7QFm4_A6hmr1Yv7qjc-iNuHNxhrali6StSMtWYwwtxuX44-UEd3W_pBpkwX6i3IQJQqk-mS7SThSqUP8X7I5yxUzsFaacvQlgmpAGJh604CrnfBKwfbjQvo2sIxZRUrO1lzWXHE4p9KUYbEY0r_iZ3CviaMM9osGv0ZqCyGl0A" }

  let(:wrong_sig_jwt) { "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzUxMiJ9.eyJzdWIiOiIxOTA3Iiwicm9sZXMiOlsiQURNSU4iXSwibmFtZSI6IlN0ZXZlIEhvZWtzZW1hIiwiZW1haWwiOiJteXRvdXJzQGtvdGlyaS5jb20iLCJwYXJ0bmVycyI6W3siYXVkIjoibXl0b3VycyIsInJvbGVzIjpbIkFETUlOIl19XSwiYWNjb3VudHMiOlt7ImF1ZCI6IjE3NzYiLCJyb2xlcyI6WyJBRE1JTiJdfV0sImV4dGVybmFsIjpbeyJpc3MiOiJnb29nbGUiLCJhY2Nlc3NfdG9rZW4iOiJ5YTI5LkdsdnFBOC1CeFhxU2tUamctYk10amx5Tm1xNU1kaUFZcDBkM3JqaHhyNm9fbFZOYzcwc1cwNWFzZlBfbDUtbXFJRGdvUWR3QnJmbzlhQVpad3Z2Qkd3NUZvajV2bnZnT1g5bDB2RzFZQy1jajBwVVUzRWFaZ1YtR0FQdzciLCJyZWZyZXNoX3Rva2VuIjoiMS94ekNTTkV1bWItN0tPM1FNOXl1bUdXX2ZHemUyR1doMlRPdk9EMWNYLUhnIn1dfQ.f0JuGQ3KPTRXxwCcDiUxBUWCH198E50ScdEGilzojqSpcEV8wyUTtsVnYPKJouR2iT0fSEMCuGFNcNRjbLr5T7lalEBisMijSgc6Iu2Db0LjkFe5fyvEQioqMUfPB-lkmoRfY9E2Hvh5K8Itvj0p_xQKQ6VLjne39wFpBbz33m7Yc0vDfwIFaOPgHkETwvajYMnlI0KJAGxuyPnv_U9joaxL_Cy5NwbG--zxwIqyGJ94NffynEk0Ohs8ZxC5tW7HgfFllYEv21dmCsLnfCB0ALnXBRXI_LQDzZPbH9LwNxmZwOKbBndp_s0UwJSGoFsf79Q9uXXxxBlVD6-SEis_a57LkD7hr_wOEKdBCik8jSwcTTXJ8VSNQK9QV2ToNLbfqKNgcpJo1h0qhQVASLolwxLPj6aaAGh27tgCIOcTeGG-tsgrkHi7JlUO_3XgJq_ciqu_wMqNoobF9m_wIJ79lh3FytO6CKzEocs521JeSChLA8_fCl8-oBf1yK_dy9OjjNKMZ1AO6A_5qn5Z2hFeIk0zAGMO0o42lhHuV5KDw0euaurMEGu51ZFGbqYXdMmOW3_m_t7oEF-UHvmzj9J1BWinEtKwT5AWa3X9KYi_2DxdOu2JoA9uEpyAAxGSFBX-thWI36CfwuqNdDljeNJciVcxcCenC8gFNadPFo-UNQU" }

  let(:wrong_format_jwt) { "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzUxMiJ9.eyJzdGF0dXMiOiJpbnZhbGlkIn0.YMBfqpv2JqPlKCqtudIu2i3_Q6r8DBrl48XiOm6IpPIa38KIBQPBdz_q2Vz1uyNSecVbY6la4xUyrSwwCFDefFooVdVimG-ztettWnaOPiT2H1xfpI4kBMDOwUeyyInz0VZswNr2mXIFDDx3QucgHT9lHGDL7bb9yI9GZV-WOHwTvp3GIiQd3PlNxw73cE1CQLLzJByMWRs4wgNi7fsfKQdhhsztbZS4f2SstYHUNWXZfKXX61Nlzt_ibVUd8yTU4J58dOV83hQyblVDn2r5jWMaqqyt0BJks5aiqGMhg2UupoEiTyy5UN1PZyMFoouy3aLw-YlFJzPD8-3WhG5cFOfJB2FqbhijGE2cqM_xhE9iT9gKsA2cI-N4FwFsxWlwyah5cMxf-MFgOv5e4QuvNQGiZaFpvnvTgBl_p3qbLRi6h7oucI9lKLk7U0gDza0BaJzNuymP8yurg72I0lkXCmGZr1-p3UYN4fEn_LN1EVTAS40qgSS0GG69cjHSbuF8flhjxBkxoTKcEHGoyjuFPT2f-6feBXR0LftWQ1dbmX1w6WoiZStMNIyQOxv0cYqPVl2hr13GD8z1gOx1FfCmIL7q0D7-TQmakpNhLQ4A3YBovoZT74lm7wmZg9xKL6g9VgDgtv85jGw6rfjElZ3SNvuKfZsVSD9n2ESPKxppLtQ" }

  it "succeeds when called with a valid header" do
    expect { validator.call(header: "Bearer #{valid_jwt}") }.to_not raise_error
  end

  it "returns a json payload" do
    payload = validator.call(header: "Bearer #{valid_jwt}")

    expect(payload).to be_a_kind_of(AuthenticJwt::Payload::Session)
    expect(payload.as_json).to eq({
                                    "accounts" => [
                                      { "aud" => "1776", "region" => "ca", "roles" => ["ADMIN"], "name" => "", "auto_approve" => false, "source" => "", "child_accounts" => [], "parent_account_id" => nil },
                                      { "aud" => "1", "region" => "ca", "roles" => ["ADMIN"], "name" => "", "auto_approve" => false, "source" => "", "child_accounts" => [], "parent_account_id" => nil }
                                    ],
                                    "email" => "mytours@kotiri.com",
                                    "exp" => 0,
                                    "external" => [{ "iss" => "google", "access_token" => "ya29.GlvqA8Wkq73ErbPl_I5WeTgvr9nMPDf9Y9bG3iyZWiB8vuUJFfrBoU6xWJKM__attd9CpWuBGXCPlEtgQX-uOdt6RXa0Y57CTQA6WObLt1Ljc1wZCx3GOaPz8k-e", "refresh_token" => "1/EJKCjLk_fs76jgrKQBUEC0gFPuOxkR7ni7u_nQqg7vk", "secret" => "" }],
                                    "iat" => 0,
                                    "jti" => "6095d1c8-4034-4647-a1c1-76e1b24482fc",
                                    "jwt_token_version" => 0,
                                    "name" => "Steve Hoeksema",
                                    "partners" => [{ "aud" => "mytours", "roles" => ["ADMIN"] }],
                                    "roles" => ["ADMIN"],
                                    "signup_provider" => "",
                                    "sub" => "1907",
                                    "username" => "",
                                    "interface_language" => "",
                                    "region" => "ca"
                                  })
  end

  it "fails when called without a header" do
    expect { validator.call(header: nil) }.to raise_error(AuthenticJwt::Unauthorized, "Authorization header missing")
    expect { validator.call(header: "") }.to raise_error(AuthenticJwt::Unauthorized, "Authorization header missing")
  end

  it "fails when called with an invalid header" do
    expect { validator.call(header: "Booger foo") }.to raise_error(AuthenticJwt::Unauthorized, "Authorization header is not a Bearer token")
  end

  it "fails when called with an invalid jwt" do
    expect { validator.call(header: "Bearer foo") }.to raise_error(AuthenticJwt::Unauthorized, "Bearer token is not a valid JWT")
  end

  it "fails when called with a jwt signed with the wrong signature" do
    expect { validator.call(header: "Bearer #{wrong_sig_jwt}") }.to raise_error(AuthenticJwt::Unauthorized, "JWT does not match signature")
  end

  it "does not fail when called with a signed jwt with unknown attributes" do
    validator.call(header: "Bearer #{wrong_format_jwt}")
  end
end
