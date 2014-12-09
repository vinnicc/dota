describe Dota::API::LiveMatch::Player do
  let(:player) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      first_match = matches.first
      players = first_match.players
      players.first
    end
  end

  specify "#id" do
    expect(player.id).to eq 34145091
  end

  specify "#name" do
    expect(player.name).to eq "Lunar Gato @ CSPL.ru"
  end

  specify "#hero" do
    expect(player.hero).to be_a Dota::API::Hero
  end

  specify "#team" do
    expect(player.team).to eq :radiant
  end
end