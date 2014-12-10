describe Dota::API::LiveMatch::Side do
  let(:side) do
    VCR.use_cassette("GetLiveLeagueGames") do
      matches = test_client.live_matches
      first_match = matches.first
      first_match.dire
    end
  end

  specify "#id" do
    expect(side.id).to eq 1846074
  end

  specify "#name" do
    expect(side.name).to eq "Haunti Gaming"
  end

  specify "#logo_id" do
    expect(side.logo_id).to eq 547513665869798854
  end

  specify "#complete?" do
    expect(side.complete?).to eq false
  end
end
