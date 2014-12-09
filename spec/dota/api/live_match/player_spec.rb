describe Dota::API::LiveMatch::Player do
  let(:player) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      first_match = matches.first
      players = first_match.players
      players.first
    end
  end

  specify "#account_id" do
    expect(player.account_id).to eq 249029055
  end

  specify "#name" do
    expect(player.name).to eq "SingSing"
  end

  specify "#hero" do
    expect(player.hero).to be_a Dota::API::Hero
  end

  specify "#team" do
    expect(player.team).to eq 1
  end
end