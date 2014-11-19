describe Dota::API::Match::Player do
  let(:player) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.matches(sample_match_id).players.first
    end
  end

  specify "#id" do
    expect(player.id).to eq 98887913
  end

  specify "#hero" do
    expect(player.hero).to be_a Dota::API::Hero
  end

  specify "#slot" do
    expect(player.slot).to eq 0
  end

  specify "#status" do
    expect(player.status).to eq :played
  end

  specify "#level" do
    expect(player.level).to eq 11
  end

  specify "#kills" do
    expect(player.kills).to eq 2
  end

  specify "#deaths" do
    expect(player.deaths).to eq 1
  end

  specify "#assists" do
    expect(player.assists).to eq 13
  end

  specify "#last_hits" do
    expect(player.last_hits).to eq 45
  end

  specify "#denies" do
    expect(player.denies).to eq 0
  end

  specify "#gold" do
    expect(player.gold).to eq 649
  end

  specify "#gold_spent" do
    expect(player.gold_spent).to eq 6670
  end

  specify "#gpm" do
    expect(player.gpm).to eq 437
  end

  specify "#xpm" do
    expect(player.xpm).to eq 460
  end

  specify "#hero_damage" do
    expect(player.hero_damage).to eq 3577
  end

  specify "#tower_damage" do
    expect(player.tower_damage).to eq 153
  end

  specify "#hero_healing" do
    expect(player.hero_healing).to eq 526
  end

  specify "#items" do
    expect(player.items.count).to eq 6
    expect(player.items.first).to be_a Dota::API::Item
  end
end
