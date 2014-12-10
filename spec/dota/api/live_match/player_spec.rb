describe Dota::API::LiveMatch::Player do
  let(:player) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      first_match = matches.first
      players = first_match.radiant.players
      players.at(3)
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

  specify "#kills" do
    expect(player.kills).to eq 4
  end

  specify "#deaths" do
    expect(player.deaths).to eq 6
  end

  specify "#assists" do
    expect(player.assists).to eq 15
  end

  specify "#slot" do
    expect(player.slot).to eq 4
  end

  specify "#last_hits" do
    expect(player.last_hits).to eq 42
  end

  specify "#denies" do
    expect(player.denies).to eq 3
  end

  specify "#gold" do
    expect(player.gold).to eq 3131
  end

  specify "#level" do
    expect(player.level).to eq 19
  end

  specify "#gpm" do
    expect(player.gpm).to eq 279
  end

  specify "#xpm" do
    expect(player.xpm).to eq 409
  end

  specify "#ultimate_state" do
    expect(player.ultimate_state).to eq 3
  end

  specify "#ultimate_cooldown" do
    expect(player.ultimate_cooldown).to eq 0
  end

  specify "#items" do
    expect(player.items.count).to eq 6
    expect(player.items.first).to be_an Dota::API::Item
  end

  specify "#respawn_timer" do
    expect(player.respawn_timer).to eq 0
  end

  specify "#position_x" do
    expect(player.position_x).to eq -4874.2314453125
  end

  specify "#position_y" do
    expect(player.position_y).to eq -4778.44677734375
  end

  specify "#net_worth" do
    expect(player.net_worth).to eq 11531
  end
end
