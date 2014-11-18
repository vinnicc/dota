describe Dota::API::Hero do
  let(:item) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.match(sample_match_id).players.first.hero
    end
  end

  specify "#id" do
    expect(item.id).to eq 69
  end

  specify "#name" do
    expect(item.name).to eq "Doom"
  end

  specify "#image_url" do
    expect(item.image_url).to eq "http://cdn.dota2.com/apps/dota2/images/heroes/doom_bringer_full.png"
  end
end
