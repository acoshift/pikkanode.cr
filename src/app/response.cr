require "json"

abstract class Response
  abstract def to_json()
end

class Response::Error < Response
  JSON.mapping(
    error: String
  )

  def initialize(@error) end
end

class Response::SignUp < Response
  JSON.mapping(
    success: Bool
  )

  def initialize(@success) end
end

class Response::SignIn < Response
  JSON.mapping(
    token: String,
    user_id: String
  )

  def initialize(@token, @user_id) end
end

class Response::SignOut < Response
  JSON.mapping(
    success: Bool
  )

  def initialize(@success) end
end
