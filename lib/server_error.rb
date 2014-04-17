require "server_error/version"
require 'rack/request'
require 'rack/response'
require 'json'

class ServerError
  def initialize app
    @app = app
  end

  def call env
    begin
      @app.call env
    rescue
      response = Rack::Response.new do |r|
        r.status = 500
        r["Content-Type"] = "application/json"
        r.write JSON.dump({message: 'unexpected error'})
      end
      response.finish
    end
  end
end
