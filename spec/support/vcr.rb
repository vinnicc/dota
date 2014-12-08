require 'vcr'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.hook_into :webmock
  c.cassette_library_dir = File.join(File.dirname(__FILE__), "..", "fixtures", "vcr_cassettes")
  c.configure_rspec_metadata!
  c.filter_sensitive_data("<STEAM_API_KEY>") { ENV.fetch("STEAM_API_KEY") }

  c.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end
end
