describe Dota::API::Match do
  let(:match) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.matches(sample_match_id)
    end
  end

  specify "#id" do
    expect(match.id).to eq sample_match_id
  end

  specify "#league_id" do
    expect(match.league_id).to eq 600
  end

  specify "#type" do
    expect(match.type).to eq "Tournament"
  end

  specify "#type_id" do
    expect(match.type_id).to eq 2
  end

  specify "#mode" do
    expect(match.mode).to eq "Captain's Mode"
  end

  specify "#mode_id" do
    expect(match.mode_id).to eq 2
  end

  specify "#players" do
    players = match.players
    expect(players.count).to eq 10
    expect(players.first).to be_a Dota::API::Match::Player
  end

  specify "#drafts" do
    drafts = match.drafts
    expect(drafts.count).to eq 20
    expect(drafts.first).to be_a Dota::API::Match::Draft
  end

  specify "#sequence" do
    expect(match.sequence).to eq 709365483
  end

  specify "#starts_at" do
    expect(match.starts_at).to eq Time.at(1405973570)
  end

  specify "#duration" do
    expect(match.duration).to eq 908
  end

  specify "#winner" do
    expect(match.winner).to eq :radiant
  end

  specify "#first_blood" do
    expect(match.first_blood).to eq 33
  end

  specify "#positive_votes" do
    expect(match.positive_votes).to eq 34701
  end

  specify "#negative_votes" do
    expect(match.negative_votes).to eq 13291
  end

  specify "#season" do
    expect(match.season).to be_nil
  end

  specify "#players_count" do
    expect(match.players_count).to eq 10
  end

  specify "#cluster" do
    expect(match.cluster).to eq 111
  end

  specify "#radiant_tower_status" do
    expect(match.radiant_tower_status).to eq 2039
  end

  specify "#dire_tower_status" do
    expect(match.dire_tower_status).to eq 1974
  end

  specify "#radiant_barracks_status" do
    expect(match.radiant_barracks_status).to eq 63
  end

  specify "#dire_barracks_status" do
    expect(match.dire_barracks_status).to eq 63
  end

  specify "#radiant_id" do
    expect(match.radiant_id).to eq 1375614
  end

  specify "#radiant_name" do
    expect(match.radiant_name).to eq "Newbee"
  end

  specify "#radiant_logo_id" do
    expect(match.radiant_logo_id).to eq 794064971723724234
  end

  specify "#radiant_complete?" do
    expect(match.radiant_complete?).to eq true
  end

  specify "#radiant_captain_id" do
    expect(match.radiant_captain_id).to eq 98887913
  end

  specify "#dire_id" do
    expect(match.dire_id).to eq 726228
  end

  specify "#dire_name" do
    expect(match.dire_name).to eq "Vici Gaming"
  end

  specify "#dire_logo_id" do
    expect(match.dire_logo_id).to eq 34096951715893495
  end

  specify "#dire_complete?" do
    expect(match.dire_complete?).to eq true
  end

  specify "#dire_captain_id" do
    expect(match.dire_captain_id).to eq 91698091
  end
end
