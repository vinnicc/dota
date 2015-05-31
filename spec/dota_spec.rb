RSpec.describe Dota do
  describe "configuration" do
    it "accepts an api key" do
      api_key = SecureRandom.hex
      Dota.configure do |config|
        config.api_key = api_key
      end

      expect(Dota.configuration.api_key).to eq api_key
    end

    it "accepts an api version" do
      expect(Dota.configuration.api_version).to eq "v1"

      Dota.configure do |config|
        config.api_version = "v2"
      end

      expect(Dota.configuration.api_version).to eq "v2"
    end
  end

  describe "usage" do
    let(:api) { Dota.api }

    before do
      expect(Dota).to receive(:api).and_return(test_client)
    end

    describe "#heroes" do
      it "given an id returns a single hero" do
        hero = api.heroes(43)
        expect(hero).to be_a Dota::API::Hero
      end

      it "without params returns all heroes" do
        hero = api.heroes.first
        expect(hero).to be_a Dota::API::Hero
      end
    end

    describe "#items" do
      it "given an id returns a single item" do
        item = api.items(114)
        expect(item).to be_a Dota::API::Item
      end

      it "without params returns all items" do
        item = api.items.first
        expect(item).to be_a Dota::API::Item
      end
    end

    describe "#matches" do
      context "given an id" do
        it "returns a single team" do
          VCR.use_cassette("GetTeamInfoByTeamID") do
            team = api.teams(sample_team_id)
            expect(team).to be_a Dota::API::Team
          end
        end
      end

      context "without args" do
        it "returns a list of teams" do
          VCR.use_cassette("GetTeamInfoByTeamID_many") do
            teams = api.teams
            expect(teams.count).to eq 100
            expect(teams.first).to be_a Dota::API::Team
          end
        end
      end

      context "given a hash" do
        accepted_params = {
          after: :start_at_team_id,
          limit: :teams_requested
        }
        accepted_params.each do |local, remote|

          specify ":#{local} should translate to :#{remote}" do
            random_value = SecureRandom.hex
            VCR.use_cassette("GetTeamInfoByTeamID") do
              expect(api).to receive(:get).with("IDOTA2Match_570", "GetTeamInfoByTeamID", remote => random_value) { double.as_null_object }
              api.teams(local => random_value)
            end
          end
        end
      end
    end

    specify "#leagues" do
      VCR.use_cassette("GetLeagueListing") do
        league = api.leagues.first
        expect(league).to be_a Dota::API::League
      end
    end

    describe "#scheduled_matches" do
      context "without args" do
        it "returns all of the scheduled matches" do
          VCR.use_cassette("GetScheduledLeagueGames") do
            matches = api.scheduled_matches
            expect(matches.first).to be_a Dota::API::ScheduledMatch
          end
        end
      end

      context "given a hash" do
        accepted_params = {
          from: :date_min,
          to:   :date_max
        }
        accepted_params.each do |local, remote|

          specify ":#{local} should translate to :#{remote}" do
            random_value = SecureRandom.hex
            VCR.use_cassette("GetScheduledLeagueGames") do
              expect(api).to receive(:get).with("IDOTA2Match_570", "GetScheduledLeagueGames", remote => random_value) { double.as_null_object }
              api.scheduled_matches(local => random_value)
            end
          end
        end
      end
    end

    describe "#live_matches" do
      context "without args" do
        it "returns all live league matches" do
          VCR.use_cassette("GetLiveLeagueGames") do
            matches = api.live_matches
            expect(matches.first).to be_a Dota::API::LiveMatch
          end
        end
      end

      context "given a hash" do
        accepted_params = {
          league_id: :league_id,
          match_id:  :match_id
        }
        accepted_params.each do |local, remote|

          specify ":#{local} should translate to :#{remote}" do
            random_value = SecureRandom.hex
            VCR.use_cassette("GetLiveLeagueGames") do
              expect(api).to receive(:get).with("IDOTA2Match_570", "GetLiveLeagueGames", remote => random_value) { double.as_null_object }
              api.live_matches(local => random_value)
            end
          end
        end
      end
    end

    specify "#cosmetic_rarities" do
      VCR.use_cassette("GetRarities") do
        rarities = api.cosmetic_rarities
        expect(rarities.first).to be_a Dota::API::Cosmetic::Rarity
      end
    end

    describe "#friends" do
      it "given a user id returns its friend list" do
        VCR.use_cassette("GetFriendList") do
          friends = api.friends(sample_user_id)
          expect(friends.first).to be_a Dota::API::Friend
        end
      end
    end

    describe "#teams" do
      context "given an id" do
        it "returns a single team" do
          VCR.use_cassette("GetMatchDetails") do
            match = api.matches(sample_match_id)
            expect(match).to be_a Dota::API::Match
          end
        end
      end

      context "without args" do
        it "returns match history" do
          VCR.use_cassette("GetMatchHistory") do
            matches = api.matches
            expect(matches.count).to eq 100
            expect(matches.first).to be_a Dota::API::Match
          end
        end
      end

      context "given a hash" do
        accepted_params = {
          hero_id:     :hero_id,
          mode_id:     :game_mode,
          skill_level: :skill,
          from:        :date_min,
          to:          :date_max,
          player_id:   :account_id,
          league_id:   :league_id,
          after:       :start_at_match_id,
          limit:       :matches_requested,
          league_only: :tournament_games_only
        }
        accepted_params.each do |local, remote|

          specify ":#{local} should translate to :#{remote}" do
            random_value = SecureRandom.hex
            VCR.use_cassette("GetMatchHistory") do
              expect(api).to receive(:get).with("IDOTA2Match_570", "GetMatchHistory", remote => random_value) { double.as_null_object }
              api.matches(local => random_value)
            end
          end
        end
      end
    end

    describe "#get" do
      it "allows custom API requests" do
        VCR.use_cassette("GetRarities") do
          # Expect api_version override to work
          api.configuration.api_version = "v99999"
          expect(Faraday).to receive(:new).with(/\/v1/).and_call_original

          response = api.get("IEconDOTA2_570", "GetRarities", { api_version: "v1", language: "en" })
          expect(response["result"]["count"]).to eq 8
        end
      end
    end
  end
end
