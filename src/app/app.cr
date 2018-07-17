require "http/server"
require "db"
require "crypto/bcrypt"
require "../error"
require "./**"

class App
  def initialize(@port : Int32, @db : DB::Database)
    @not_found = Handler::NotFound.new
    @sign_up = Handler::SignUp.new @db
    @sign_in = Handler::SignIn.new @db
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
      @sign_up.call(context)
    when "/signin"
      @sign_in.call(context)
    else
      @not_found.call(context)
    end
  end
end
