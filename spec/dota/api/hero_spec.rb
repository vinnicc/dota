RSpec.describe Dota::API::Hero do
  let(:hero) { described_class.new(69) }

  specify ".all" do
    heroes = described_class.all
    expect(heroes.first).to be_a described_class
    expect(heroes.count).to eq 115
  end

  specify ".find" do
    expect(described_class.find(69)).to be_a Dota::API::Hero
    expect(described_class.find(nil)).to be_a Dota::API::MissingHero
    expect(described_class.find("abc")).to be_a Dota::API::MissingHero
  end

  specify "#id" do
    expect(hero.id).to eq 69
  end

  specify "#name" do
    expect(hero.name).to eq "Doom"
  end

  specify "#image_url" do
    expect(hero.image_url).to eq "http://cdn.dota2.com/apps/dota2/images/heroes/doom_bringer_full.png"
  end
end
