describe Dota::API::MatchSchedule do
  let(:match) do
    VCR.use_cassette("GetScheduledLeagueGames") do
      test_client.match.first
    end
  end

  specify "#league_id" do
    expect(match.id).to eq 2057
  end

  specify "#game_id" do
    expect(match.game_id).to eq 27
  end

  specify "#teams" do
    expect(match.teams).to eq []
  end

  specify "#starttime" do
    expect(match.start_time).to eq 1418531400
  end

  specify "#comment" do
    expect(match.comment).to eq ""
  end

  specify "#final" do
    expect(match.final).to eq false
  end 
end