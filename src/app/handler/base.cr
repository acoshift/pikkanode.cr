abstract class Handler::Base
  include HTTP::Handler

  abstract def call(context)

  # def parse(context : HTTP::Server::Context)
  #   body = context.request.body

  #   # TODO: fixme senpai :D
  #   # return error(context, "invalid request", 400) if body.nil?

  #   T.new(JSON::PullParser.new(body))
  # end

  def response(context : HTTP::Server::Context, r : Response, status : Int32 = 200)
    context.response.content_type = "application/json; charset=utf-8"
    context.response.status_code = status
    context.response.print r.to_json
  end

  def error(context, err : String = "Internal Server Error", status : Int32 = 500)
    response(context, Response::Error.new(err), status)
  end
end
