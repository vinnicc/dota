describe Dota do
  describe "configuration" do
    it "accepts an api key" do
      random_string = SecureRandom.hex
      Dota.configure do |config|
        config.api_key = random_string
      end

      expect(Dota.configuration.api_key).to eq random_string
    end
  end

  describe "usage" do
    let(:api) { Dota.api }

    before do
      expect(Dota).to receive(:api).and_return(test_client)
    end

    describe "#heroes" do
      it "given an id returns a single hero" do
        hero = api.heroes(43)
        expect(hero).to be_a Dota::API::Hero
      end

      it "without params returns all heroes" do
        hero = api.heroes.first
        expect(hero).to be_a Dota::API::Hero
      end
    end

    describe "#items" do
      it "given an id returns a single item" do
        item = api.items(114)
        expect(item).to be_a Dota::API::Item
      end

      it "without params returns all items" do
        item = api.items.first
        expect(item).to be_a Dota::API::Item
      end
    end

    specify "#matches" do
      VCR.use_cassette("GetMatchDetails") do
        match = api.matches(sample_match_id)
        expect(match).to be_a Dota::API::Match
      end
    end

    specify "#leagues" do
      VCR.use_cassette("GetLeagueListing") do
        league = api.leagues.first
        expect(league).to be_a Dota::API::League
      end
    end
  end
end
