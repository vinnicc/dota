RSpec.describe Dota::API::Match::Player do
  let(:match) do
    VCR.use_cassette("GetMatchDetailsUnits") do
      test_client.matches(sample_match_id_with_units)
    end
  end
  let(:player) { match.dire.players[1] }

  specify "#id" do
    expect(player.id).to eq 76482434
  end

  specify "#hero" do
    expect(player.hero).to be_a Dota::API::Hero
  end

  specify "#slot" do
    expect(player.slot).to eq 2

    expect(match.radiant.players.map(&:slot)).to eq [1, 2, 3, 4, 5]
    expect(match.dire.players.map(&:slot)).to eq [1, 2, 3, 4, 5]
  end

  specify "#status" do
    expect(player.status).to eq :played
  end

  specify "#level" do
    expect(player.level).to eq 17
  end

  specify "#kills" do
    expect(player.kills).to eq 7
  end

  specify "#deaths" do
    expect(player.deaths).to eq 0
  end

  specify "#assists" do
    expect(player.assists).to eq 10
  end

  specify "#last_hits" do
    expect(player.last_hits).to eq 240
  end

  specify "#denies" do
    expect(player.denies).to eq 6
  end

  specify "#gold" do
    expect(player.gold).to eq 1938
  end

  specify "#gold_spent" do
    expect(player.gold_spent).to eq 19120
  end

  specify "#gpm" do
    expect(player.gpm).to eq 660
  end

  specify "#xpm" do
    expect(player.xpm).to eq 502
  end

  specify "#hero_damage" do
    expect(player.hero_damage).to eq 12601
  end

  specify "#tower_damage" do
    expect(player.tower_damage).to eq 10972
  end

  specify "#hero_healing" do
    expect(player.hero_healing).to eq 0
  end

  specify "#additional_units" do
    expect(player.additional_units.count).to eq 1
    expect(player.additional_units.first).to be_a Dota::API::Match::Unit
  end

  specify "#items" do
    expect(player.items.count).to eq 6
    expect(player.items.first).to be_a Dota::API::Item
  end

  specify "#ability_upgrades" do
    expect(player.ability_upgrades.count).to eq 11
    expect(player.ability_upgrades.first).to be_a Dota::API::Match::AbilityUpgrade
  end
end
