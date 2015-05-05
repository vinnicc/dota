RSpec.describe Dota::API::Team do
  let(:team) do
    VCR.use_cassette("GetTeamInfoByTeamID") do
      test_client.teams(sample_team_id)
    end
  end

  specify "#id" do
    expect(team.id).to eq sample_team_id
  end

  specify "#name" do
    expect(team.name).to eq "Newbee"
  end

  specify "#tag" do
    expect(team.tag).to eq "Newbee"
  end

  specify "#country_code" do
    expect(team.country_code).to eq "cn"
  end

  specify "#rating" do
    expect(team.rating).to eq "inactive"
  end

  specify "#logo_id" do
    expect(team.logo_id).to eq 794064971723724234
  end

  specify "#sponsor_logo_id" do
    expect(team.sponsor_logo_id).to eq 532872513435338107
  end

  specify "#matches_with_current_roster" do
    expect(team.matches_with_current_roster).to eq 0
  end

  specify "#url" do
    expect(team.url).to eq "http://t.qq.com/NBgaming"
  end

  specify "#player_ids" do
    expect(team.player_ids).to eq [88508515, 89157606, 89217927, 100883708, 123854991]
  end

  specify "#admin_id" do
    expect(team.admin_id).to eq 104652351
  end

  specify "#created_at" do
    expect(team.created_at).to eq Time.at(1393518254)
  end
end
