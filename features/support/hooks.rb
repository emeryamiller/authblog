After do |scenario|
  mock = OmniAuth.config.mock_auth.dup
  mock.delete_if {|key, value| key != :default}
  OmniAuth.config.mock_auth = mock
end
