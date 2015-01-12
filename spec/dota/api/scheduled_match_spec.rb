describe Dota::API::ScheduledMatch do
  let(:scheduled_match) do
    VCR.use_cassette("GetScheduledLeagueGames") do
      test_client.scheduled_matches.first
    end
  end

  specify "#league_id" do
    expect(scheduled_match.league_id).to eq 2057
  end

  specify "#game_id" do
    expect(scheduled_match.game_id).to eq 27
  end

  specify "#teams" do
    team = scheduled_match.teams
    expect(team.first).to be_a Dota::API::Team

    # `Team#name` should still return the team's name even if the api returns a
    # different key "team_name" from the expected "name"
    expect(team.first.name).to eq "Team Poker Face"
  end

  specify "#starts_at" do
    expect(scheduled_match.starts_at).to eq Time.at(1418531400)
  end

  specify "#description" do
    expect(scheduled_match.description).to eq ""
  end

  specify "#final?" do
    expect(scheduled_match.final?).to eq false
  end 
end
