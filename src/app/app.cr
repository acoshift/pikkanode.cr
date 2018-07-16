require "http/server"
require "db"
require "crypto/bcrypt"
require "../error"
require "./**"

module Pikkanode
  class App
    def initialize(port : Int32, db : DB::Database)
      @port = port
      @db = db
    end

    def start
      server = HTTP::Server.new do |context|
        router(context)
      end

      puts "Listening on http://0.0.0.0:#{@port}"
      server.listen(@port)
    end

    def router(context : HTTP::Server::Context)
      path = context.request.path
      case path
      when "/signup"
        signup(context)
      else
        not_found(context)
      end
    end

    def signup(context : HTTP::Server::Context)
      body = context.request.body
      if context.request.method != "POST" || body.is_a?(Nil)
        response(context, Error.new("invalid request").to_json, 400)
        return
      end

      begin
        req = Request::SignUp.new(JSON::PullParser.new(body))

        hashedPassword = Crypto::Bcrypt.hash_secret(req.password)

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

    def not_found(context : HTTP::Server::Context)
      response(context, Error.new("not found").to_json, 404)
    end

    def response(context : HTTP::Server::Context, r : String, status : Int32 = 200)
      context.response.content_type = "application/json; charset=utf-8"
      context.response.status_code = status
      context.response.print r
    end
  end
end
