require "http/server"
require "db"
require "./base"

class Handler::SignUp < Handler::Base
  def initialize(@db : DB::Database) end

  def call(context)
    body = context.request.body

    return error(context, "method not allowed", 405) unless context.request.method == "POST"
    return error(context, "invalid request", 400) if body.nil?

    begin
      req = Request::SignUp.new(JSON::PullParser.new(body))

      hashedPassword = Crypto::Bcrypt::Password.create(req.password)

      @db.exec "
        insert into users
          (username, password)
        values
          ($1, $2)
      ", req.username, hashedPassword

      response(context, Response::SignUp.new(true).to_json, 200)
    rescue ex
      response(context, Error.new("invalid request").to_json, 400)
    end
  end
end
