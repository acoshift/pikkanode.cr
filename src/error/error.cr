require "json"

class Error
  JSON.mapping(
    error: String
  )

  def initialize(@error) end
end