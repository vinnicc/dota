RSpec.describe Dota::API::Match::Unit do
  let(:additional_unit) do
    VCR.use_cassette("GetMatchDetails") do
      test_client
        .matches(sample_match_id)
        .radiant
        .players.last
        .additional_units.first
    end
  end
  let(:item) { additional_unit.items.first }

  specify "#name" do
    expect(additional_unit.name).to eq "Spirit Bear"
  end

  specify "#items" do
    expect(item).to be_a Dota::API::Item
    expect(item.name).to eq "Phase Boots"
  end
end