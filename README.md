# Dota

Dota is a Ruby client for the [Dota 2 WebAPI](https://wiki.teamfortress.com/wiki/WebAPI#Dota_2). It provides an easy way to access matches, players, heroes, items, and other public Dota 2 objects in an opinionated manner.

This gem is in alpha. Take note when upgrading.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dota'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dota

## Usage

```ruby
Dota.configure do |config|
  config.api_key = "STEAM_API_KEY"
end

api = Dota.api
```

Get your Steam API key [here](http://steamcommunity.com/dev/apikey).

### Features

What follows is a list of API methods supported by the gem:

#### Get a single match

```ruby
api.match(MATCH_ID)
```

## Contributing

1. [Fork It](https://github.com/vinnicc/dota/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
