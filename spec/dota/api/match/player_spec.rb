RSpec.describe Dota::API::Match::Player do
  let(:match) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.matches(sample_match_id)
    end
  end
  let(:player) { match.radiant.players.last }

  specify "#id" do
    expect(player.id).to eq 76482434
  end

  specify "#hero" do
    expect(Dota::API::Hero).to receive(:find).and_call_original
    expect(player.hero).to be_a Dota::API::Hero
  end

  specify "#slot" do
    expect(player.slot).to eq 5

    expect(match.radiant.players.map(&:slot)).to eq [1, 2, 3, 4, 5]
    expect(match.dire.players.map(&:slot)).to eq [1, 2, 3, 4, 5]
  end

  specify "#status" do
    expect(player.status).to eq :played
  end

  specify "#level" do
    expect(player.level).to eq 21
  end

  specify "#kills" do
    expect(player.kills).to eq 1
  end

  specify "#deaths" do
    expect(player.deaths).to eq 3
  end

  specify "#assists" do
    expect(player.assists).to eq 2
  end

  specify "#last_hits" do
    expect(player.last_hits).to eq 395
  end

  specify "#denies" do
    expect(player.denies).to eq 19
  end

  specify "#gold" do
    expect(player.gold).to eq 2349
  end

  specify "#gold_spent" do
    expect(player.gold_spent).to eq 24770
  end

  specify "#gpm" do
    expect(player.gpm).to eq 536
  end

  specify "#xpm" do
    expect(player.xpm).to eq 472
  end

  specify "#hero_damage" do
    expect(player.hero_damage).to eq 7012
  end

  specify "#tower_damage" do
    expect(player.tower_damage).to eq 1114
  end

  specify "#hero_healing" do
    expect(player.hero_healing).to eq 15
  end

  specify "#additional_units" do
    expect(player.additional_units.count).to eq 1
    expect(player.additional_units.first).to be_a Dota::API::Match::Unit
  end

  specify "#items" do
    expect(player.items.count).to eq 6
    expect(player.items.first).to be_a Dota::API::Item
  end
end
