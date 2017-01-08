RSpec.describe Dota::API::Ability do
  let(:ability) { described_class.new(5003) }

  specify ".all" do
    abilities = described_class.all
    expect(abilities.first).to be_a described_class
    expect(abilities.count).to eq 1077
  end

  specify "#id" do
    expect(ability.id).to eq 5003
  end

  describe "#name" do
    specify "returns a human-friendly name" do
      expect(ability.name).to eq "Mana Break"
    end

    specify "falls back to internal name" do
      ability = described_class.new(9993)
      expect(ability.name).to eq "roshan_halloween_wave_of_force"
    end
  end

  specify "#full_name" do
    # DEPRECATED: Used to just concatenate hero name
    # with ability (e.g., "Antimage Mana Break")
    expect(ability.full_name).to eq "Mana Break"
  end

  specify "#image_url" do
    expect(ability.image_url).to eq "http://cdn.dota2.com/apps/dota2/images/abilities/antimage_mana_break_lg.png"
  end
end
