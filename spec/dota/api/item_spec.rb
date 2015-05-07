RSpec.describe Dota::API::Item do
  let(:item) { described_class.new(1) }

  specify ".all" do
    items = described_class.all
    expect(items.first).to be_a described_class
    expect(items.count).to eq 238
  end

  specify "#id" do
    expect(item.id).to eq 1
  end

  specify "#name" do
    expect(item.name).to eq "Blink Dagger"
  end

  specify "#image_url" do
    expect(item.image_url).to eq "http://cdn.dota2.com/apps/dota2/images/items/blink_lg.png"
  end
end
