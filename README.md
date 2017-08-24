# Dota [![Gem Version](https://badge.fury.io/rb/dota.svg)](http://badge.fury.io/rb/dota) [![Build Status](https://travis-ci.org/vinnicc/dota.svg?branch=master)](https://travis-ci.org/vinnicc/dota) [![Code Climate](https://codeclimate.com/github/vinnicc/dota/badges/gpa.svg)](https://codeclimate.com/github/vinnicc/dota) [![Test Coverage](https://codeclimate.com/github/vinnicc/dota/badges/coverage.svg)](https://codeclimate.com/github/vinnicc/dota/coverage)

`dota` is a Ruby client for the [Dota 2 WebAPI](https://wiki.teamfortress.com/wiki/WebAPI#Dota_2).

## Requests

Valve provides a `GetSupportedAPIList` endpoint that returns all the available endpoints in their API you can use, along with the parameters they accept. The following are supported by `dota`:

- GetLeagueListing
- GetMatchDetails
- GetMatchHistory
- GetFriendList
- GetHeroes
- GetGameItems
- GetRarities
- GetTeamInfoByTeamID
- GetLiveLeagueGames
- GetScheduledLeagueGames

Unsupported endpoints (including `GetSupportedAPIList`) can still be queried via [custom requests](#custom-requests) using `Dota.api.get`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dota', '~> 0.0.21'

```

And then execute:

    $ bundle

Or install it in your local repository:

    $ gem install dota -v 0.0.21

## Usage

Get your Steam API key [here](http://steamcommunity.com/dev/apikey) and make sure the gem is configured to use it. If you're using Rails, this might go in an initializer like `config/initializers/dota.rb`.

```ruby
Dota.configure do |config|
  config.api_key = ENV.fetch("STEAM_API_KEY")

  # Set API version (defaults to "v1")
  # config.api_version = "v1"
end
```

Then use the client:

```ruby
api = Dota.api

api.heroes(43)                   # => (Cached) A single hero - "Death Prophet"
api.heroes                       # => (Cached) All heroes

api.items(114)                   # => (Cached) A single item - "Heart of Tarrasque"
api.items                        # => (Cached) All items

api.abilities(5003)              # => (Cached) A single ability - "Mana Break"
api.abilities                    # => (Cached) All abilities

api.cosmetic_rarities            # => All cosmetic rarities

api.teams(1375614)               # => A single team - "Newbee"
api.teams                        # => A list of teams
api.teams(after: 1375614)        #    Allowed options:
                                 #
                                 #    :after - Integer, With team IDs equal or greater than this
                                 #    :limit - Integer, Amount of teams to return (default is 100)

api.leagues                      # => All leagues

api.matches(789645621)           # => A single match - "Newbee vs Vici Gaming"
api.matches                      # => A list of matches
api.matches(hero_id: 43)         #    Allowed options:
                                 #
                                 #    :hero_id     - Integer, With this hero. See Dota::API::Hero.mapping
                                 #    :after       - Integer, With match IDs equal or less than this
                                 #    :player_id   - Integer, With this player (32-bit Steam ID)
                                 #    :league_id   - Integer, In this league. Use Dota.leagues to get a list of leagues
                                 #    :mode_id     - Integer, In this game mode. See Dota::API::Match::MODES
                                 #    :skill_level - Integer, In this skill level (ignored if :player_id is provided). See Dota::API::Match::SKILL_LEVELS
                                 #    :from        - Integer, Minimum timestamp
                                 #    :to          - Integer, Maximum timestamp
                                 #    :min_players - Integer, With at least this number of players
                                 #    :league_only - Boolean, Only league matches
                                 #    :limit       - Integer, Amount of matches to return (default is 100)

api.live_matches                 # => All live league matches
api.live_matches(league_id: 600) #    Allowed options:
                                 #
                                 #    :league_id - Integer, In this league. Use Dota.leagues to get a list of leagues
                                 #    :match_id  - Integer, With this match

api.scheduled_matches            # => All scheduled league matches
api.scheduled_matches(from: 123) #    Allowed options:
                                 #
                                 #    :from - Integer, Minimum timestamp
                                 #    :to   - Integer, Maximum timestamp

api.friends(76561198052976237)   # => All friends of user
```

#### Custom Requests

For the unsupported endpoints, you can use `api.get`. For example, the following code is similar to `api.matches(789645621)` except it will return the raw JSON payload instead of an array of `Dota::Match`es.

```ruby
api.get("IDOTA2Match_570", "GetMatchDetails", match_id: 789645621)
```

Setting `api_version` here also overrides the current configuration:

```ruby
api.get("IDOTA2Match_570", "GetMatchDetails", match_id: 789645621, api_version: "v1")
```

### API Objects

#### Heroes

```ruby
hero.id        # Integer, ID of the hero
hero.name      # String, Name of the hero
hero.image_url # String, URL of the hero portrait
```

#### Items

```ruby
item.id        # Integer, ID of the item
item.name      # String, Name of the item
item.image_url # String, URL of the item image
```

#### Teams

```ruby
team.id              # Integer, ID of the team
team.name            # String, Name of the team
team.tag             # String, Abbreviation tag of the team
team.country_code    # String, ISO 3166-1 country code (see http://en.wikipedia.org/wiki/ISO_3166-1#Current_codes)
team.admin_id        # Integer, Team admin's 32-bit Steam ID
team.player_ids      # Array[Integer], Players' 32-bit Steam IDs
team.logo_id         # Integer, UGC ID of the team's logo
team.sponsor_logo_id # Integer, UGC ID of the sponsor's logo
team.rating          # String, ???
team.url             # String, URL of the team's website
team.created_at      # Time, When the team was created
```

#### Leagues

```ruby
league.id          # Integer, ID of the league
league.name        # String, Name of the league
league.description # String, A description of the league
league.url         # String, URL of the league's website
```

#### Matches

Caveat: Getting a list of matches via `api.matches` will call [GetMatchHistory](https://wiki.teamfortress.com/wiki/WebAPI/GetMatchHistory) which has very few attributes for the matches returned (obviously for performance reasons), as opposed to getting info about a particular match via `api.matches(id)` which will instead call [GetMatchDetails](https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails). In both cases, the matches returned will be instances of `Dota::API::Match`. In the future, there will be subclasses to distinguish the two.

When an instance method in a `Dota::API::Match` class returns `nil`, it most likely means the endpoint called doesn't provide it yet.

```ruby
match.radiant        # Dota::API::Match::Side, Info about the team on the Radiant side
match.dire           # Dota::API::Match::Side, Info about the team on the Dire side

match.id             # Integer, ID of the match
match.league_id      # Integer, ID of the league this match was a part of
match.type           # String, See Dota::API::Match::TYPES
match.type_id        # Integer, See Dota::API::Match::TYPES
match.mode           # String, See Dota::API::Match::MODES
match.mode_id        # Integer, See Dota::API::Match::MODES
match.sequence       # Integer, A 'sequence number', representing the order in which matches were recorded
match.season         # Integer, Season the match was played in
match.cluster        # Integer, Server cluster the match was played on
match.starts_at      # Time, When the match started
match.first_blood    # Integer, Seconds since the match started when first blood occurred
match.duration       # Integer, Length of the match, in seconds since the match began
match.winner         # Symbol, :radiant or :dire
match.positive_votes # Integer, Number of thumbs-up the game has received
match.negative_votes # Integer, Number of thumbs-down the game has received
match.players_count  # Integer, Number of players in the match

match.drafts         # Array[Dota::API::Match::Draft], Picks and bans in the match, if the game mode is "Captains Mode"

# Dota::API::Match::Draft
draft.order          # Integer, 1-20
draft.pick?          # Boolean, true if the draft is a pick, and not a ban
draft.team           # Symbol, :radiant or :dire
draft.hero           # Dota::API::Hero || Dota::API::MissingHero, Picked or banned hero
```

#### Live Matches

```ruby
live_match.radiant          # Dota::API::LiveMatch::Side, Info about the team on the Radiant side
live_match.dire             # Dota::API::LiveMatch::Side, Info about the team on the Dire side

live_match.id               # Integer, ID of the match
live_match.lobby_id         # Integer, ID of the lobby
live_match.spectators_count # Integer, Number of spectators watching on DotaTV
live_match.league_id        # Integer, ID of the league
live_match.stream_delay     # Integer, Number of seconds the stream is behind actual game time
live_match.series_type      # Integer, Best of X series
live_match.league_tier      # String, What tier the match's league is
live_match.duration         # Integer, Length of the match, in seconds since the match began
live_match.roshan_timer     # Integer, Seconds until Roshan respawns
```

#### Scheduled Matches

```ruby
scheduled_match.league_id   # Integer, ID of the league
scheduled_match.game_id     # Integer, ID of the game
scheduled_match.teams       # Array[Dota::API::Team], List of teams who are playing each other
scheduled_match.starts_at   # Time, When the match is scheduled to start
scheduled_match.description # String, Description of the match
scheduled_match.final?      # Boolean, true if the game is the last of the series
```

#### Sides - Radiant/Dire

```ruby
radiant.id              # Integer, Team's ID
radiant.logo_id         # Integer, Team logo's UGC ID
radiant.name            # String, Team's name
radiant.complete?       # Boolean, true if the team's roster is complete
radiant.players         # Array[Dota::API::Match::Player|Dota::API::LiveMatch::Player], Players in the match
radiant.tower_status    # Hash, Status of team's towers (`true` - tower is standing, `false` - tower is destroyed)
radiant.barracks_status # Hash, Status of team's barracks (`true` - barrack is standing, `false` - barrack is destroyed)

# Additional methods in Match::Side
radiant.captain_id      # Integer, Team captain's 32-bit Steam ID

# Additional methods in LiveMatch::Side
radiant.score       # Integer, The team's current score
radiant.series_wins # Integer, Number of wins in the series so far
```

#### Players

```ruby
player.id                # Integer, 32-bit Steam ID
player.hero              # Dota::API::Hero || Dota::API::MissingHero, Player's hero
player.items             # Array[Dota::API::Item], Player's inventory (6 items)
player.slot              # Integer, (1-5)
player.level             # Integer, The player's level at match end
player.kills             # Integer, Number of kills attributed to this player
player.deaths            # Integer, Times this player died during the match
player.assists           # Integer, Number of assists the player got
player.last_hits         # Integer, Number of last-hits the player got
player.denies            # Integer, Number of denies the player got
player.gold              # Integer, Amount of gold the player had remaining at the end of the match
player.gpm               # Integer, Player's overall gold/minute
player.xpm               # Integer, Player's overall experience/minute

# Additional methods in Match::Player
player.status            # Symbol, :played, :left_safe, :abandoned, or :bot
player.gold_spent        # Integer, Amount of gold the player spent
player.hero_damage       # Integer, Amount of damage the player dealt to heroes
player.tower_damage      # Integer, Amount of damage the player dealt to towers
player.hero_healing      # Integer, Amount of health the player had healed on heroes
player.additional_units  # Array[Dota::API::Unit], Units under player's control (for example, summoned ones)
player.ability_upgrades  # Array[Dota::API:AbilityUpgrade], Player's learned abilities (up to 25)

# Additional methods in LiveMatch::Player
player.name              # String, Name of the player
player.net_worth         # Integer
player.ultimate_state    # Integer
player.ultimate_cooldown # Integer
player.respawn_timer     # Integer
player.position_x        # Float
player.position_y        # Float
```

#### Units

```ruby
unit.name  # String, Unit's name
unit.items # Array[Dota::API:Item], Unit's inventory (6 slots)
```

#### Ability Upgrades

```ruby
ability_upgrade.time    # Integer, Seconds since the match started when the player learned an ability
ability_upgrade.level   # Integer, Player's level when the ability was learned
ability_upgrade.ability # Dota::API::Ability
```

#### Abilities

```ruby
ability.id        # Integer, ID of the ability
ability.name      # String, Name of the ability (for example, "Mana Break")
ability.image_url # String, URL of the ability image
                  # Allowed arguments:
                  # :lg  - default, 128x128 PNG image
                  # :hp1 - 90x90 PNG image
                  # :hp2 - 105x105 PNG image
```

#### Cosmetic Rarities

```ruby
rarity.id    # Integer, ID of the rarity, used for indexing
rarity.order # Integer, Sorting and logical order, from most distributed to least
rarity.name  # String, Localized display name
rarity.color # String, The hexadecimal RGB tuple
```

#### Friends

```ruby
friend.id           # Integer, Friend's 64-bit Steam ID
friend.relationship # String, Relation to the player
friend.made_at      # Time, When the friend was added to the player's friend list
```

## Resources

- [Steam-Powered DOTA on Rails](http://www.sitepoint.com/steam-powered-dota-on-rails/) and [DOTA 2 on Rails: Digging Deeper](http://www.sitepoint.com/dota-2-rails-digging-deeper/) by Ilya Bodrov-Krukowski - A tutorial for getting personal match statistics that makes use of this library for Steam integration. (www.sitepoint.com)
- [Things You Should Know Before Starting API Development](http://dev.dota2.com/showthread.php?t=58317) by MuppetMaster42 (dev.dota2.com)
- [Dota 2 WebAPI Wiki](https://wiki.teamfortress.com/wiki/WebAPI#Dota_2) (wiki.teamfortress.com)
- [Dota 2 WebAPI Forums](http://dev.dota2.com/forumdisplay.php?f=411) (dev.dota2.com)

## License

Copyright © Vinni Carlo Caños

Distributed under the [MIT License](http://www.opensource.org/licenses/MIT).
