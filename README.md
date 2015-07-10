# Omniauth::Timecrowd

## API Document

https://timecrowd.net/apidoc

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-timecrowd', github: ruffnote/omniauth-timecrowd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-timecrowd

## Example

Register application on https://timecrowd.net/oauth/applications/new.  
(Redirect URI: `http://localhost:PORT/auth/timecrowd/callback`)

```
$ cd example

# .env
TIMECROWD_CLIENT_ID="ID"
TIMECROWD_CLIENT_SECRET="SECRET"
TIMECROWD_SITE="https://timecrowd.net/"

$ rails s -p PORT
$ open http://localhost:PORT/
```

## Acknowledgements

https://github.com/intridea/omniauth-github

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

