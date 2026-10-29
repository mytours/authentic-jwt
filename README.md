# AuthenticJwt

TODO

## Installation

Add this line to your application's Gemfile:

```ruby
gem "authentic-jwt"
```

## Usage

### Audience

Since 1.14.0, `AuthenticJwt::Validator` refuses a token that carries `aud`, which Authentic sets on an agent's grant, unless the caller names that audience. The refusal is `AuthenticJwt::WrongAudience`, a subclass of `AuthenticJwt::Unauthorized`.

```ruby
AuthenticJwt::Validator.new                                                  # tokens without aud only
AuthenticJwt::Validator.new(audience: ENV["AGENT_AUDIENCE"])                 # aud must equal it; a blank value accepts nothing
AuthenticJwt::Validator.new(audience: ENV["AGENT_AUDIENCE"], first_party: true) # either
```

In Grape, a route passes the same options through `route_setting :oauth2, scope: "read", audience: -> { ENV["AGENT_AUDIENCE"] }, first_party: true`, or `oauth2 "read", audience: ...`. A callable audience is read per request.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mytours/authentic-jwt.
