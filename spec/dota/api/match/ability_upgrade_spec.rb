RSpec.describe Dota::API::Match::AbilityUpgrade do
  let(:ability_upgrade) do
    VCR.use_cassette("GetMatchDetails") do
      test_client
        .matches(sample_match_id)
        .radiant
        .players
        .first
        .ability_upgrades
        .last
    end
  end

  specify "#ability" do
    expect(ability_upgrade.ability).to be_a Dota::API::Ability
  end

  specify "#level" do
    expect(ability_upgrade.level).to eq 17
  end

  specify "#time" do
    expect(ability_upgrade.time).to eq 3823
  end
end