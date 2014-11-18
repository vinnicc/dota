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

    specify "#hero" do
      match = api.hero(43)
      expect(match).to be_a Dota::API::Hero
    end

    specify "#item" do
      match = api.item(114)
      expect(match).to be_a Dota::API::Item
    end

    specify "#match" do
      VCR.use_cassette("GetMatchDetails") do
        match = api.match(sample_match_id)
        expect(match).to be_a(Dota::API::Match)
      end
    end

    specify "#leagues" do
      VCR.use_cassette("GetLeagueListing") do
        league = api.leagues.first
        expect(league).to be_a(Dota::API::League)
      end
    end
  end
end
