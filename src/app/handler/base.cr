require "http/server"

abstract class Handler::Base
  include HTTP::Handler

  abstract def call(context)

  def response(context : HTTP::Server::Context, r : String, status : Int32 = 200)
    context.response.content_type = "application/json; charset=utf-8"
    context.response.status_code = status
    context.response.print r
  end

  def error(context, err : String = "Internal Server Error", status : Int32 = 500)
    response(context, Error.new(err).to_json, status)
  end
end
