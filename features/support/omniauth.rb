OmniAuth.config.mock_auth[:google]={"provider"=>"google",
  "uid"=>"https://www.google.com/accounts/o8/id?id=someuniqueid",
  "user_info"=>{"email"=>"user@gmail.com",
    "first_name"=>"First", "last_name"=>"Last", "name"=>"First Last"}}

OmniAuth.config.mock_auth[:open_id]= {"provider"=>"open_id", 
  "uid"=>"https://me.yahoo.com/a/someuniqueid",
  "user_info"=>{"email"=>"user@yahoo.com", 
    "name"=>"Yahoo Last", "nickname"=>"Nickname"}}
