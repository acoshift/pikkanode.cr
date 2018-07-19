class Handler::NotFound < Handler::Base
  def call(context)
    error(context, "not found", 404)
  end
end
