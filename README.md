# Dota

Dota is a Ruby client for the [Dota 2 WebAPI](https://wiki.teamfortress.com/wiki/WebAPI#Dota_2). It provides an easy way to access matches, players, heroes, items, and other public Dota 2 objects in an opinionated manner.

This gem is in alpha, keep that in mind when upgrading. Documentation is also still lacking. In the meantime, just do `SomeClass.instance_methods(false)` to see what methods are exposed.

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
  config.api_key = "YOUR_STEAM_API_KEY"
end

api = Dota.api
```

Get your Steam API key [here](http://steamcommunity.com/dev/apikey). What follows is a list of API methods currently available:

```ruby
api.match(MATCH_ID) # => Dota::API::Match
api.leagues         # => [Dota::API::League, ...]
```

### API Objects

You won't need to instantiate on these classes directly and it's not advisable to do so as the API might change anytime. Using `Dota.api` alone should be enough in most cases.

#### Dota::API::Item

```ruby
item.id        # => 114
item.name      # => "Heart of Tarrasque"
item.image_url # => "http://cdn.dota2.com/apps/dota2/images/items/heart_lg.png"
```

#### Dota::API::Hero

```ruby
hero.id        # => 43
hero.name      # => "Death Prophet"
hero.image_url # => "http://cdn.dota2.com/apps/dota2/images/heroes/death_prophet_full.png"
```

#### Dota::API::Match

```ruby
XXX: TODO
```

#### Dota::API::Match::Player

```ruby
XXX: TODO
```

#### Dota::API::League

```ruby
league.id          # => 600
league.name        # => "The International 2014"
league.description # => "The Aegis of Champions hangs in the balance. See the world's top teams battle in the International."
league.url         # => "http://www.dota2.com/international/overview/"
```

## TODO

1. Move API documentation to https://readthedocs.org/ or somewhere else
2. Implement all Dota 2 WebAPI methods
3. Better search filters
4. Computed attributes such as win rates, hero usage, etc.
5. ???

## Contributing

1. [Fork It](https://github.com/vinnicc/dota/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
