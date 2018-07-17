require "json"

class Response::SignUp
  JSON.mapping(
    success: Bool
  )

  def initialize(@success) end
end

class Response::SignIn
  JSON.mapping(
    token: String,
    user_id: String
  )

  def initialize(@token, @user_id) end
end
