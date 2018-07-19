require "json"

class Token
  JSON.mapping(
    user_id: String
  )

  getter id : String = ""

  def initialize(@id : String, @user_id) end
end
