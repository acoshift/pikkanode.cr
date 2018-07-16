require "json"

module Pikkanode
  class Error
    JSON.mapping(
      error: String
    )

    def initialize(error : String)
      @error = error
    end
  end
end