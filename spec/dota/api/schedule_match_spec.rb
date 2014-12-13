describe Dota::API::ScheduleMatch do
  let(:schedule_match) do
    VCR.use_cassette("GetScheduledLeagueGames") do
      test_client.schedule_matches.first
    end
  end

  specify "#league_id" do
    expect(schedule_match.league_id).to eq 2057
  end

  specify "#game_id" do
    expect(schedule_match.game_id).to eq 27
  end

  specify "#teams" do
    expect(schedule_match.teams).to eq []
  end

  specify "#starttime" do
    expect(schedule_match.start_time).to eq 1418531400
  end

  specify "#comment" do
    expect(schedule_match.comment).to eq ""
  end

  specify "#final" do
    expect(schedule_match.final?).to eq false
  end 
end