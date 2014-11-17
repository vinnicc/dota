require 'faraday'
require 'faraday_middleware'

module Dota
  module API
    class Client
      def match(id)
        response = do_request("GetMatchDetails", match_id: id)["result"]
        Match.new(response) if response
      end

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield configuration
      end

      private

      def do_request(method, options = {}, interface = "IDOTA2Match_570", method_version = "V001")
        url = "https://api.steampowered.com/#{interface}/#{method}/#{method_version}/"

        @faraday = Faraday.new(url) do |faraday|
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end

        response = @faraday.get do |request|
          request.url(url, options.merge(key: configuration.api_key))
        end
        response.body
      end
    end
  end
end
