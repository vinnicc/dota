describe Dota::API::Item do
  let(:item) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.match(sample_match_id).players.first.items.first
    end
  end

  specify "#id" do
    expect(item.id).to eq 1
  end

  specify "#name" do
    expect(item.name).to eq "blink"
  end
end
