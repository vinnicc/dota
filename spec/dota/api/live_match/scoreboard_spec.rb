describe Dota::API::LiveMatch::Scoreboard do
  let(:scoreboard) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      first_match = matches.first
      first_match.scoreboard
    end
  end

  specify "#duration" do
    expect(scoreboard.duration).to eq 2390
  end

  specify "#roshan_timer" do
    expect(scoreboard.roshan_timer).to eq 145
  end

  #specify "#radiant"
  #  expect(scoreboard.radiant).to eq { hash }
  #end

  #specify "#dire"
  #  expect(scoreboard.dire).to eq { hash }
  #end
end