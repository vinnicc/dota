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
api.hero(43)         # => Dota::API::Hero
api.item(114)        # => Dota::API::Item
api.match(789645621) # => Dota::API::Match
api.leagues          # => [Dota::API::League, ...]
```

### API Objects

You won't need to instantiate on these classes directly and it's not advisable to do so as the API might change anytime. Starting with the call to `Dota.api` should be enough in most cases.

#### Dota::API::Hero

```ruby
hero.id        # => 43
hero.name      # => "Death Prophet"
hero.image_url # => "http://cdn.dota2.com/apps/dota2/images/heroes/death_prophet_full.png"
```

#### Dota::API::Item

```ruby
item.id        # => 114
item.name      # => "Heart of Tarrasque"
item.image_url # => "http://cdn.dota2.com/apps/dota2/images/items/heart_lg.png"
```

#### Dota::API::Match

```ruby
match.id                      # => 789645621
match.league_id               # => 600
match.drafts                  # => [Dota::API::Match::Draft, ...]
match.players                 # => [Dota::API::Match::Player, ...]
match.sequence                # => 709365483
match.starts_at               # => 2014-07-21 20:12:50 UTC
match.duration                # => 908
match.winner                  # => :radiant
match.first_blood             # => 33
match.positive_votes          # => 34701
match.negative_votes          # => 13291
match.season                  # => nil
match.human_players           # => 10
match.cluster                 # => 111
match.mode                    # => 2
match.lobby                   # => 2
match.radiant_tower_status    # => 2039
match.dire_tower_status       # => 1974
match.radiant_barracks_status # => 63
match.dire_barracks_status    # => 63
```

#### Dota::API::Match::Player

```ruby
player.id           # => 98887913
player.hero         # => Dota::API::Hero
player.items        # => [Dota::API::Item, ...]
player.slot         # => 0
player.status       # => :played
player.level        # => 11
player.kills        # => 2
player.deaths       # => 1
player.assists      # => 13
player.last_hits    # => 45
player.denies       # => 0
player.gold         # => 649
player.gold_spent   # => 6670
player.gpm          # => 437
player.xpm          # => 460
player.hero_damage  # => 3577
player.tower_damage # => 153
player.hero_healing # => 526
```

#### Dota::API::Match::Draft

```ruby
draft.hero  # => Dota::API::Hero
draft.order # => 1
draft.pick? # => true
```

#### Dota::API::League

```ruby
league.id          # => 600
league.name        # => "The International 2014"
league.description # => "The Aegis of Champions hangs in the balance. See the world's top teams battle in the International."
league.url         # => "http://www.dota2.com/international/overview/"
```

## TODO

- Validations and error classes
- More configuration options
- Move API documentation to https://readthedocs.org/ or somewhere else
- Implement all Dota 2 WebAPI methods
- Better search filters
- Computed attributes such as win rates, hero usage, etc.
- ???

## Contributing

1. [Fork It](https://github.com/vinnicc/dota/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
