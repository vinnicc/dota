# Dota [![Gem Version](https://badge.fury.io/rb/dota.svg)](http://badge.fury.io/rb/dota) [![Build Status](https://travis-ci.org/vinnicc/dota.svg?branch=master)](https://travis-ci.org/vinnicc/dota)

`dota` is a Ruby client for the [Dota 2 WebAPI](https://wiki.teamfortress.com/wiki/WebAPI#Dota_2). It provides an easy way to access matches, players, heroes, items, and other public Dota 2 objects in an opinionated manner.

Currently supported endpoints:

- [GetLeagueListing](https://wiki.teamfortress.com/wiki/WebAPI/GetLeagueListing)
- [GetMatchDetails](https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails)
- [GetMatchHistory](https://wiki.teamfortress.com/wiki/WebAPI/GetMatchHistory)
- [GetFriendList](https://wiki.teamfortress.com/wiki/WebAPI/GetFriendList)
- [GetHeroes](https://wiki.teamfortress.com/wiki/WebAPI/GetHeroes)
- GetGameItems
- [GetRarities](https://wiki.teamfortress.com/wiki/WebAPI/GetRarities)
- [GetTeamInfoByTeamID](https://wiki.teamfortress.com/wiki/WebAPI/GetTeamInfoByTeamID)
- [GetLiveLeagueGames](https://wiki.teamfortress.com/wiki/WebAPI/GetLiveLeagueGames) # scoreboard not fully functional

Unsupported endpoints can still be queried via [custom requests](#custom-requests).

This gem is in alpha, keep that in mind when upgrading.

## TODO

- Support for more endpoints
  - [GetMatchHistoryBySequenceNum](https://wiki.teamfortress.com/wiki/WebAPI/GetMatchHistoryBySequenceNum)
  - [GetPlayerSummaries](https://wiki.teamfortress.com/wiki/WebAPI/GetPlayerSummaries)
  - [GetScheduledLeagueGames](https://wiki.teamfortress.com/wiki/WebAPI/GetScheduledLeagueGames)
  - [GetTournamentPlayerStats](https://wiki.teamfortress.com/wiki/WebAPI/GetTournamentPlayerStats)
  - [GetTournamentPrizePool](https://wiki.teamfortress.com/wiki/WebAPI/GetTournamentPrizePool)
- Validations and error classes
- More configuration options
- Move API documentation to [readthedocs.org](https://readthedocs.org/) or somewhere else
- Better search filters
- Computed attributes such as win rates, hero usage, etc.

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
  config.api_key = ENV.fetch("STEAM_API_KEY")
end
```

Get your Steam API key [here](http://steamcommunity.com/dev/apikey).

```ruby
api = Dota.api

api.heroes(43)                 # => (Cached) A single hero - "Death Prophet"
api.heroes                     # => (Cached) All heroes

api.items(114)                 # => (Cached) A single item - "Heart of Tarrasque"
api.items                      # => (Cached) All items

api.cosmetic_rarities          # => All cosmetic rarities

api.teams(1375614)             # => A single team - "Newbee"
api.teams                      # => A list of teams
api.teams(after: 1375614)      #    Allowed options:
                               #
                               #    :after - Integer, With team IDs equal or greater than this
                               #    :limit - Integer, Amount of teams to return (default is 100)

api.leagues                    # => All leagues

api.matches(789645621)         # => A single match - "Newbee vs Vici Gaming"
api.matches                    # => A list of matches
api.matches(hero_id: 43)       #    Allowed options:
                               #
                               #    :hero_id     - Integer, With this hero. See Dota::API::Hero::MAPPING
                               #    :after       - Integer, With match IDs equal or greater than this
                               #    :player_id   - Integer, With this player (32-bit Steam ID)
                               #    :league_id   - Integer, In this league. Use Dota.leagues to get a list of leagues
                               #    :mode_id     - Integer, In this game mode. See Dota::API::Match::MODES
                               #    :skill_level - Integer, In this skill level (ignored if :player_id is provided). See Dota::API::Match::SKILL_LEVELS
                               #    :from        - Integer, Minimum timestamp
                               #    :to          - Integer, Maximum timestamp
                               #    :min_players - Integer, With at least this number of players
                               #    :league_only - Boolean, Only league matches
                               #    :limit       - Integer, Amount of matches to return (default is 100)

api.friends(76561198052976237) # => All friends of user
```

#### Custom Requests

For the unsupported endpoints, you can use `api.get`. For example, the following code is similar to `api.matches(789645621)` except it will return the raw JSON payload instead of an array of `Dota::Match`es.

```ruby
api.get("IDOTA2Match_570", "GetMatchDetails", match_id: 789645621)
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
match.id                      # Integer, ID of the match
match.league_id               # Integer, ID of the league this match was a part of
match.type                    # String, See Dota::API::Match::TYPES
match.type_id                 # Integer, See Dota::API::Match::TYPES
match.mode                    # String, See Dota::API::Match::MODES
match.mode_id                 # Integer, See Dota::API::Match::MODES
match.sequence                # Integer, A 'sequence number', representing the order in which matches were recorded
match.season                  # Integer, Season the match was played in
match.cluster                 # Integer, Server cluster the match was played on
match.drafts                  # Array[Dota::API::Match::Draft], Picks and bans in the match, if the game mode is "Captains Mode"
match.players                 # Array[Dota::API::Match::Player], Players in the match
match.players_count           # Integer, Number of players in the match
match.starts_at               # Time, When the match started
match.first_blood             # Integer, Seconds since the match started when first blood occured
match.duration                # Integer, Length of the match, in seconds since the match began.
match.winner                  # Symbol, :radiant or :dire
match.positive_votes          # Integer, Number of thumbs-up the game has received
match.negative_votes          # Integer, Number of thumbs-down the game has received

match.radiant_id              # Integer, Radiant team's ID
match.radiant_captain_id      # Integer, Radiant captain's 32-bit Steam ID
match.radiant_logo_id         # Integer, Radiant logo's UGC ID
match.radiant_name            # String, Radiant team's name
match.radiant_complete?       # Boolean, true if the Radiant team's roster is complete
match.radiant_tower_status    # Integer, See https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails # Tower_Status
match.radiant_barracks_status # Integer, See https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails # Barracks_Status

match.dire_id                 # Integer, Dire team's ID
match.dire_captain_id         # Integer, Dire captain's 32-bit Steam ID
match.dire_logo_id            # Integer, Dire logo's UGC ID
match.dire_name               # String, Dire team's name
match.dire_complete?          # Boolean, true if the Dire team's roster is complete
match.dire_tower_status       # Integer, See https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails # Tower_Status
match.dire_barracks_status    # Integer, See https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails # Barracks_Status
```

#### Players

```ruby
player.id           # Integer, 32-bit Steam ID
player.hero         # Dota::API::Hero, Player's hero
player.items        # Array[Dota::API::Item], Player's inventory (6 items)
player.slot         # Integer, See https://wiki.teamfortress.com/wiki/WebAPI/GetMatchDetails#Player_Slot
player.status       # Symbol, :played, :left_safe, :abandoned, or :bot
player.level        # Integer, The player's level at match end
player.kills        # Integer, Number of kills attributed to this player
player.deaths       # Integer, Times this player died during the match
player.assists      # Integer, Number of assists the player got
player.last_hits    # Integer, Number of last-hits the player got
player.denies       # Integer, Number of denies the player got
player.gold         # Integer, Amount of gold the player had remaining at the end of the match
player.gold_spent   # Integer, Amount of gold the player spent
player.gpm          # Integer, Player's overall gold/minute
player.xpm          # Integer, Player's overall experience/minute
player.hero_damage  # Integer, Amount of damage the player dealt to heroes
player.tower_damage # Integer, Amount of damage the player dealt to towers
player.hero_healing # Integer, Amount of health the player had healed on heroes
```

#### Drafts

```ruby
draft.order # Integer, 1-20
draft.pick? # Boolean, true if the draft is a pick, and not a ban
draft.team  # Symbol, :radiant or :dire
draft.hero  # Dota::API::Hero, Picked or banned hero
```

#### Cosmetic Rarities

```ruby
rarity.id    # Integer, ID of rarity, used for indexing
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

#### Live Matches
```ruby
live_matches.id                   # Integer, Id of match
live_matches.lobby_id             # Integer, Id of lobby
live_matches.spectators_count     # Integer, Number of spectators watching on DotaTV
live_matches.league_id            # Dota::API::League, League of live game
live_matches.stream_delay_count   # Integer, Number of seconds that the stream is behind actual game time
live_matches.radiant_series_wins  # Integer, Number of wins the radiant team has in the series
live_matches.dire_series_wins     # Integer, Number of wins the dire team has in the series
live_matches.radiant              # Dota::API::LiveMatch::Side, Info about the team on the radiant side 
live_matches.dire                 # Dota::API::LiveMatch::Side, Info about the team on the dire side
live_matches.series_type          # Integer, Best of X series
live_matches.league_tier          # String, What tier the match is 
live_matches.players              # Array[Dota::API::LiveMatch::Players], High level info about the players in the match (some info is redudant in scoreboard)
live_matches.scoreboard           # Hash, A hash of the scoreboard (to be converted soon to a object / integrated with our players class)
```

## Contributing

1. [Fork it!](https://github.com/vinnicc/dota/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
