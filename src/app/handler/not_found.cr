require "http/server"
require "./base"

class Handler::NotFound < Handler::Base
  def call(context)
    response(context, Error.new("not found").to_json, 404)
  end
end
