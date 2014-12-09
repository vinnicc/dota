describe Dota::API::LiveMatch::Scoreboard do
  let(:scoreboard) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      first_match = matches.first
      first_match.scoreboard
    end
  end

  specify "#duration" do
    expect(scoreboard.duration).to eq 2840.2998046875
  end

  specify "#roshan_timer" do
    expect(scoreboard.roshan_timer).to eq 278
  end

  xspecify "#radiant" do
    expect(scoreboard.radiant).to eq 
  end

  xspecify "#dire" do
    expect(scoreboard.dire).to eq
  end
end