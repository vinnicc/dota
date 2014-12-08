Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'dota'

module SpecHelper
  def test_client
    return if @client

    @client = Dota::API::Client.new
    @client.configure do |config|
      config.api_key = "2FBBA83745F494FAE688AFB8463CD4FC"
    end
    @client
  end

  def sample_match_id
    789645621
  end

  def sample_user_id
    76561198052976237
  end

  def sample_team_id
    1375614
  end
end

RSpec.configure do |config|
  config.include SpecHelper
end
