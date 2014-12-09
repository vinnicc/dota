describe Dota::API::LiveMatch::Side do
  let(:side) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      first_match = matches.first
      first_match.dire
    end
  end

  specify "#name" do
    expect(side.name).to eq "name"
  end

  specify "#id" do
    expect(side.id).to eq 32909055
  end

  specify "#logo" do
    expect(side.logo).to eq 249209059
  end

  specify "#complete" do
    expect(side.logo).to eq true
  end
end