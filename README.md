# WardenLake

[![Build
Status](https://semaphoreci.com/api/v1/craftingbot/warden_lake/branches/master/badge.svg)](https://semaphoreci.com/craftingbot/warden_lake)

This rails engine adds config on top of Warden, we build strategies on
engine, help easy integration with rails app.

 To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'warden_lake'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install warden_lake

## Usage

### Basic config on initializer
To create new warden initializer under `config/initializers/`, and name
it `warden.rb`. for example:
```
# config/initializers/warden.rb
Warden::Strategies.add(:password_strategy, WardenLake::Strategies::PasswordStrategy)

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :password_strategy
  manager.failure_app = lambda { |env|
    UnauthorizedController.action(:new).call(env)
  }
end

```
The UnauthorizedController is one example, you can used what's you want,
you also found more detail on [Warden]( https://github.com/wardencommunity/warden )

To config WardenLake in `warden.rb`, append config after warden config
```
WardenLake.scope_mapping = {user: User}
WardenLake.default_scope = :user
WardenLake.identity_field = :username
```
The `scope` is come from warden, sometimes, you need authenticating
admin, user in you rails application
if you have `admin`, `user`, you could set which scope mapping which
model.
```
WardenLake.scope_mapping = {user: User, admin: Admin}
```
The Value `User`, `Admin` is rails model which will used in strategies,
and `password_strategy` is default used them.

the `identity_field` should be one field on authenticated model, if we
used `email` to login, we should make config as follow:
```
WardenLake.identity_field = :email
```

### ApplicationController Mixin
WardenLake integrated authentication with warden's strategry, so only
need mixin authenticated helpers in ApplicationController.
Finally, you should adding `before_action` in ApplciationController, for
example:
```
class ApplicationController < ActionController::Base
  include WardenLake::Authentication
  before_action authenticate_user

  def authenticate_user
    if !warden.authenticated? && current_user.blank?
      redirect_to sign_in_path
    end
  end
  def current_user
    if warden && warden.user
      @current_user ||= User.find(warden.user['id'])
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/warden_lake. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WardenLake project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/warden_lake/blob/master/CODE_OF_CONDUCT.md).
