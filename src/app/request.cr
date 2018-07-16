require "json"

module Pikkanode
  class Request::SignUp
    JSON.mapping(
      username: String,
      password: String
    )
  end
end