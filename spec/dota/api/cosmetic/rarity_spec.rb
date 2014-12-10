describe Dota::API::Cosmetic::Rarity do
  let(:rarity) do
    VCR.use_cassette("GetRarities") do
      test_client.cosmetic_rarities.last
    end
  end

  specify("#id")    { expect(rarity.id).to eq 7 }
  specify("#order") { expect(rarity.order).to eq 6 }
  specify("#color") { expect(rarity.color).to eq "#e4ae39" }
  specify("#name")  { expect(rarity.name).to eq "Immortal" }
end
