describe Dota::API::LiveMatch do
  let(:live_match) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      matches.first
    end
  end

  specify "#id" do
    expect(live_match.id).to eq 1080324763
  end

  specify "#lobby_id" do
    expect(live_match.lobby_id).to eq 23791470898109516
  end

  specify "#spectators_count" do
    expect(live_match.spectators_count).to eq 58
  end

  specify "#league_id" do
    expect(live_match.league_id).to eq 2091
  end

  specify "#stream_delay" do
    expect(live_match.stream_delay).to eq 120
  end

  specify "#radiant_series_wins" do
    expect(live_match.radiant_series_wins).to eq 0
  end

  specify "#dire_series_wins" do
    expect(live_match.dire_series_wins).to eq 0
  end

  specify "#radiant" do
    expect(live_match.radiant).to be_a Dota::API::LiveMatch::Side
  end

  specify "#dire" do
    expect(live_match.dire).to be_a Dota::API::LiveMatch::Side
  end

  specify "#series_type" do
    expect(live_match.series_type).to eq 0
  end

  specify "#league_tier" do
    expect(live_match.league_tier).to eq "Amateur"
  end

  specify "#players" do
    players = live_match.players
    expect(players.count).to eq 11
    expect(players.first).to be_a Dota::API::LiveMatch::Player
  end

  specify "#scoreboard" do
    expect(live_match.scoreboard).to be_a Dota::API::LiveMatch::Scoreboard
  end
end
