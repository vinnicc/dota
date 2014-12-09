describe Dota::API::LiveMatch do
  let(:live_match) do
    VCR.use_cassette("GetLiveLeagueGames") do
      test_client.live_matches.first
    end
  end

  specify "#id" do
    expect(live_match.id).to eq 1079288808
  end 
end