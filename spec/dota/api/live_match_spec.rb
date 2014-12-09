describe Dota::API::LiveMatch do
  let(:live_match) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      matches.first
    end
  end

  specify "#id" do
    expect(live_match.id).to eq 1079288808
  end

  specify "#lobby_id" do
    expect(live_match.lobby_id).to eq 1079288808
  end

  specify "#spectators_count" do
    expect(live_match.spectators_count).to eq 405
  end

  specify "#league" do
    expect(live_match.league).to eq 1203
  end

  specify "#stream_delay_count" do
    expect(live_match.stream_delay_count).to eq 120
  end

  specify "#radiant_wins" do
    expect(live_match.radiant_wins).to eq 0
  end

  specify "#dire_wins" do
    expect(live_match.dire_wins).to eq 2
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
    expect(live_match.league_tier).to eq 1
  end

  specify "#players" do
    players = live_match.players
    expect(players.count).to eq 10
    expect(live_match.first).to be_a Dota::API::LiveMatch::Player
  end

  specify "#scoreboard" do
    expect(live_match.scoreboard).to be_a Dota::API::Match::Draft
  end
end