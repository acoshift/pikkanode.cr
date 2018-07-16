require "json"

module Pikkanode
  class Response::SignUp
    JSON.mapping(
      success: Bool
    )

    def initialize(@success : Bool)
    end
  end
end
