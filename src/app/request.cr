require "json"

abstract class Request
  abstract def initialize(json_parser : JSON::PullParser)
end

class Request::SignUp < Request
  JSON.mapping(
    username: String,
    password: String
  )
end

class Request::SignIn < Request
  JSON.mapping(
    username: String,
    password: String
  )
end

class Request::SignOut < Request
  JSON.mapping(
    token: String
  )
end
