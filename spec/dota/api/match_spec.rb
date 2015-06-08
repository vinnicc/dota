RSpec.describe Dota::API::Match do
  let(:match) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.matches(sample_match_id)
    end
  end

  specify "#id" do
    expect(match.id).to eq sample_match_id
  end

  specify "#league_id" do
    expect(match.league_id).to eq 2129
  end

  specify "#type" do
    expect(match.type).to eq "Practice"
  end

  specify "#type_id" do
    expect(match.type_id).to eq 1
  end

  specify "#mode" do
    expect(match.mode).to eq "Captain's Mode"
  end

  specify "#mode_id" do
    expect(match.mode_id).to eq 2
  end

  describe "#drafts" do
    specify "match with drafts" do
      drafts = match.drafts
      expect(drafts.count).to eq 20
      expect(drafts.first).to be_a Dota::API::Match::Draft
    end

    specify "match without drafts" do
      expect(match.raw).to receive(:[]).with("picks_bans") { nil }
      expect(match.drafts).to eq []
    end
  end

  specify "#sequence" do
    expect(match.sequence).to eq 1283900397
  end

  specify "#starts_at" do
    expect(match.starts_at).to eq Time.at(1430252064)
  end

  specify "#duration" do
    expect(match.duration).to eq 3198
  end

  specify "#winner" do
    expect(match.winner).to eq :dire
  end

  specify "#first_blood" do
    expect(match.first_blood).to eq 448
  end

  specify "#positive_votes" do
    expect(match.positive_votes).to eq 71
  end

  specify "#negative_votes" do
    expect(match.negative_votes).to eq 18
  end

  specify "#season" do
    expect(match.season).to be_nil
  end

  specify "#players_count" do
    expect(match.players_count).to eq 10
  end

  specify "#cluster" do
    expect(match.cluster).to eq 135
  end
end
