class Handler::SignIn < Handler::Base
  def initialize(@repo : Repository) end

  def call(context)
    body = context.request.body

    return error(context, "method not allowed", 405) unless context.request.method == "POST"
    return error(context, "invalid request", 400) if body.nil?

    req = Request::SignIn.new(JSON::PullParser.new(body))

    result = @repo.find_user_by_username req.username

    return error(context, "invalid username", 400) if result.nil?

    user_id = result[:user_id]
    password = result[:password]

    return error(context, "invalid password", 400) unless Crypto::Bcrypt::Password.new(password) == req.password

    token_id = Random::Secure.base64(32)
    token = Token.new(token_id, user_id)
    @repo.register_token token

    response(context, Response::SignIn.new(token_id, user_id), 200)
  end
end