describe Dota::API::LiveMatch::Side do
  let(:live_match) do
    VCR.use_cassette("GetLiveLeagueGames") do
      test_client.live_matches.first
    end
  end
  let(:radiant) { live_match.radiant }
  let(:dire) { live_match.dire }

  specify "#id" do
    expect(radiant.id).to eq 1677303
    expect(dire.id).to eq 1846074
  end

  specify "#name" do
    expect(radiant.name).to eq "ReallyCoolGuys"
    expect(dire.name).to eq "Haunti Gaming"
  end

  specify "#logo_id" do
    expect(radiant.logo_id).to eq 29595255080842763
    expect(dire.logo_id).to eq 547513665869798854
  end

  specify "#complete?" do
    expect(radiant.complete?).to eq false
    expect(dire.complete?).to eq false
  end

  specify "#score" do
    expect(radiant.score).to eq 42
    expect(dire.score).to eq 54
  end

  specify "#series_wins" do
    expect(radiant.series_wins).to eq 0
    expect(dire.series_wins).to eq 0
  end

  specify "#tower_status" do
    expect(radiant.tower_status).to eq 1540
    expect(dire.tower_status).to eq 1958
  end

  specify "#barracks_status" do
    expect(radiant.barracks_status).to eq 3
    expect(dire.barracks_status).to eq 63
  end

  specify "#players" do
    players = radiant.players
    expect(players.count).to eq 5
    expect(players.first).to be_a Dota::API::LiveMatch::Player

    players = dire.players
    expect(players.count).to eq 5
    expect(players.first).to be_a Dota::API::LiveMatch::Player
  end
end
