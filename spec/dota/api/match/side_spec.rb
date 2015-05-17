RSpec.describe Dota::API::Match::Side do
  let(:match) do
    VCR.use_cassette("GetMatchDetails") do
      test_client.matches(sample_match_id)
    end
  end
  let(:radiant) { match.radiant }
  let(:dire) { match.dire }

  specify "#id" do
    expect(radiant.id).to eq 111474
    expect(dire.id).to eq 2085365
  end

  specify "#name" do
    expect(radiant.name).to eq "Alliance"
    expect(dire.name).to eq "-Ninjas-in-Pyjamas-"
  end

  specify "#logo_id" do
    expect(radiant.logo_id).to eq 29599162148627728
    expect(dire.logo_id).to eq 530636567528696522
  end

  specify "#complete?" do
    expect(radiant.complete?).to eq false
    expect(dire.complete?).to eq true
  end

  specify "#tower_status" do
    expect(radiant.tower_status).to eq({
                                         ancient_top: false,
                                         ancient_bottom: false,
                                         bottom_tier_3: false,
                                         bottom_tier_2: false,
                                         bottom_tier_1: false,
                                         middle_tier_3: false,
                                         middle_tier_2: false,
                                         middle_tier_1: false,
                                         top_tier_3: true,
                                         top_tier_2: true,
                                         top_tier_1: false
                                       })
    expect(dire.tower_status).to eq({
                                      ancient_top: true,
                                      ancient_bottom: true,
                                      bottom_tier_3: true,
                                      bottom_tier_2: false,
                                      bottom_tier_1: false,
                                      middle_tier_3: true,
                                      middle_tier_2: true,
                                      middle_tier_1: false,
                                      top_tier_3: true,
                                      top_tier_2: false,
                                      top_tier_1: false
                                    })
  end

  specify "#barracks_status" do
    expect(radiant.barracks_status).to eq({
                                            bottom_ranged: true,
                                            bottom_melee: true,
                                            middle_ranged: false,
                                            middle_melee: false,
                                            top_ranged: true,
                                            top_melee: true
                                          })
    expect(dire.barracks_status).to eq({
                                         bottom_ranged: true,
                                         bottom_melee: true,
                                         middle_ranged: true,
                                         middle_melee: true,
                                         top_ranged: true,
                                         top_melee: true
                                       })
  end

  specify "#captain_id" do
    expect(radiant.captain_id).to eq 88271237
    expect(dire.captain_id).to eq 18180970
  end

  specify "#players" do
    players = radiant.players
    expect(players.count).to eq 5
    expect(players.first).to be_a Dota::API::Match::Player

    players = dire.players
    expect(players.count).to eq 5
    expect(players.first).to be_a Dota::API::Match::Player
  end
end
