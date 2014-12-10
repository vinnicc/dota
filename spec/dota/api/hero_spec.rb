describe Dota::API::Hero do
  let(:hero) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.matches(sample_match_id).players.first.hero
    end
  end

  specify ".all" do
    heroes = described_class.all
    expect(heroes.first).to be_a described_class
    expect(heroes.count).to eq 109
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
