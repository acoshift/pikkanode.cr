require "http/server"
require "crypto/bcrypt"
require "./**"

class App
  def initialize(@port : Int32, repo : Repository)
    @router = Router.new repo
  end

  def start
    server = HTTP::Server.new [
      Middleware::Rescue.new,
      @router,
      Handler::NotFound.new
    ]

    puts "Listening on http://0.0.0.0:#{@port}"
    server.listen(@port)
  end
end

class Router < Handler::Base
  def initialize(repo : Repository)
    @sign_up = Handler::SignUp.new repo
    @sign_in = Handler::SignIn.new repo
    @sign_out = Handler::SignOut.new repo
  end

  def call(context)
    path = context.request.path
    case path
    when "/signup"
      @sign_up.call(context)
    when "/signin"
      @sign_in.call(context)
    when "/signout"
      @sign_out.call(context)
    else
      call_next(context)
    end
  end
end
