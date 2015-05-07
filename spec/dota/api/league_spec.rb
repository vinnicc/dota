RSpec.describe Dota::API::League do
  let(:league) do
    VCR.use_cassette("GetLeagueListing") do
      test_client.leagues.first
    end
  end

  specify "#id" do
    expect(league.id).to eq 1212
  end

  specify "#name" do
    expect(league.name).to eq "Dota 2 Just For Fun"
  end

  specify "#description" do
    expect(league.description).to eq "64 of the best Brazilian amateur teams compete to become the winner of the first Dota 2 Just For Fun tournament. "
  end

  specify "#url" do
    expect(league.url).to eq "https://binarybeast.com/xDOTA21404228/"
  end
end
