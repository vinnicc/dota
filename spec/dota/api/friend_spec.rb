describe Dota::API::Friend do
  let(:friend) do
    VCR.use_cassette("GetFriendList") do
      test_client.friends(sample_user_id).first
    end
  end

  specify "#id" do
    expect(friend.id).to eq 76561197992246166
  end

  specify "#relationship" do
    expect(friend.relationship).to eq "friend"
  end

  specify "#friended_at" do
    expect(friend.friended_at).to eq Time.at(1416242540)
  end
end
