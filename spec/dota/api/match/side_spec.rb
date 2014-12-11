describe Dota::API::Match::Side do
  let(:match) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.matches(sample_match_id)
    end
  end
  let(:radiant) { match.radiant }
  let(:dire) { match.dire }

  specify "#id" do
    expect(radiant.id).to eq 1375614
    expect(dire.id).to eq 726228
  end

  specify "#name" do
    expect(radiant.name).to eq "Newbee"
    expect(dire.name).to eq "Vici Gaming"
  end

  specify "#logo_id" do
    expect(radiant.logo_id).to eq 794064971723724234
    expect(dire.logo_id).to eq 34096951715893495
  end

  specify "#complete?" do
    expect(radiant.complete?).to eq true
    expect(dire.complete?).to eq true
  end

  specify "#tower_status" do
    expect(radiant.tower_status).to eq 2039
    expect(dire.tower_status).to eq 1974
  end

  specify "#barracks_status" do
    expect(radiant.barracks_status).to eq 63
    expect(dire.barracks_status).to eq 63
  end

  specify "#captain_id" do
    expect(radiant.captain_id).to eq 98887913
    expect(dire.captain_id).to eq 91698091
  end

  specify "#players" do
    players = radiant.players
    expect(players.count).to eq 5
    expect(players.first).to be_a Dota::API::Match::Player

    players = dire.players
    expect(players.count).to eq 5
    expect(players.first).to be_a Dota::API::Match::Player
  end
end
