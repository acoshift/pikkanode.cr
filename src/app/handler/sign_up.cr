class Handler::SignUp < Handler::Base
  def initialize(@repo : Repository) end

  def call(context)
    body = context.request.body

    return error(context, "method not allowed", 405) unless context.request.method == "POST"
    return error(context, "invalid request", 400) if body.nil?

    req = Request::SignUp.new(JSON::PullParser.new(body))

    hashed_password = Crypto::Bcrypt::Password.create(req.password).to_s

    ok = @repo.register_user req.username, hashed_password
    return error(context, "username not available", 400) unless ok

    response(context, Response::SignUp.new(true), 200)
  end
end
