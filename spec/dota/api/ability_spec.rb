RSpec.describe Dota::API::Ability do
  let(:ability) { described_class.new(5003) }

  specify ".all" do
    abilities = described_class.all
    expect(abilities.first).to be_a described_class
    expect(abilities.count).to eq 560
  end

  specify "#id" do
    expect(ability.id).to eq 5003
  end

  specify "#name" do
    expect(ability.name).to eq "Mana Break"
  end

  specify "#full_name" do
    expect(ability.full_name).to eq "Antimage Mana Break"
  end

  specify "#image_url" do
    expect(ability.image_url).to eq "http://cdn.dota2.com/apps/dota2/images/abilities/antimage_mana_break_lg.png"
  end
end