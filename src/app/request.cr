require "json"

class Request::SignUp
  JSON.mapping(
    username: String,
    password: String
  )
end

class Request::SignIn
  JSON.mapping(
    username: String,
    password: String
  )
end
