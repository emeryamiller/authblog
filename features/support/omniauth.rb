def add_oa_mock(service, email, user_info={})
  OmniAuth.config.add_mock(service.to_s.downcase, { 
    "provider" => service.to_s, 
    "uid" => "auniqueid_#{email}",
    "user_info" => {"email" => email, 
                    "name" => "First Last"}.merge(user_info) })
end

def add_invalid_oa_mock(service)
  OmniAuth.config.mock_auth[service.to_s.downcase.to_sym] = :invalid_credentials
end
