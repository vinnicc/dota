guard :rspec, cmd: "bundle exec rspec --fail-fast" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { "spec" } # or { |m| "spec/#{m[1]}_spec.rb" }
  watch("spec/spec_helper.rb")  { "spec" }
end
