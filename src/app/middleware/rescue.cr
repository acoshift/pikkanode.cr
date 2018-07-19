require "../handler/base"

class Middleware::Rescue < Handler::Base
  def call(context)
    begin
      call_next(context)
    rescue ex : JSON::Error
      error(context, "invalid request", 400)
    rescue
      error(context)
    end
  end
end
