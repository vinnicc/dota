RSpec.describe Dota::API::MissingHero do
  let(:hero) { described_class.new(nil) }

  specify "#id" do
    expect(hero.id).to eq nil
  end

  specify "#name" do
    expect(hero.name).to eq nil
  end

  specify "#image_url" do
    expect(hero.image_url).to eq nil
    expect(hero.image_url(:something)).to eq nil
  end
end
