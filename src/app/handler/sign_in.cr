require "db"
require "./base"

class Handler::SignIn < Handler::Base
  def initialize(@db : DB::Database) end

  def call(context)
    body = context.request.body

    return error(context, "method not allowed", 405) unless context.request.method == "POST"
    return error(context, "invalid request", 400) if body.nil?

    begin
      req = Request::SignIn.new(JSON::PullParser.new(body))

      user_id, password = @db.query_one "
        select
          id, password
        from users
        where username = $1
      ", req.username, as: { String, String }

      return error(context, "invalid password", 400) unless Crypto::Bcrypt::Password.new(password) == req.password

      token_id = Random::Secure.base64(32)
      token = Token.new(user_id)
      @db.exec "
        insert into tokens
          (id, data)
        values
          ($1, $2)
      ", token_id, token.to_json

      response(context, Response::SignIn.new(token_id, user_id).to_json, 200)
    rescue ex : JSON::Error
      error(context, "invalid request", 400)
    rescue ex : DB::Error
      return error(context, "invalid username", 400) if ex.message == "no rows" # yh :D
      error(context)
    rescue
      error(context)
    end
  end
end