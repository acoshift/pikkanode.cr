require "json"

class Token
  JSON.mapping(
    user_id: String
  )

  def initialize(@user_id) end
end
