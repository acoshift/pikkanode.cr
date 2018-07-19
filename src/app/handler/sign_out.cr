class Handler::SignOut < Handler::Base
  def initialize(@repo : Repository) end

    def call(context)
      body = context.request.body

      return error(context, "method not allowed", 405) unless context.request.method == "POST"
      return error(context, "invalid request", 400) if body.nil?

      req = Request::SignOut.new(JSON::PullParser.new(body))

      @repo.remove_token req.token

      response(context, Response::SignOut.new(true), 200)
    end
end
