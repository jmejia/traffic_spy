module TrafficSpy

  # Sinatra::Base - Middleware, Libraries, and Modular Apps
  #
  # Defining your app at the top-level works well for micro-apps but has
  # considerable drawbacks when building reusable components such as Rack
  # middleware, Rails metal, simple libraries with a server component, or even
  # Sinatra extensions. The top-level DSL pollutes the Object namespace and
  # assumes a micro-app style configuration (e.g., a single application file,
  # ./public and ./views directories, logging, exception detail page, etc.).
  # That's where Sinatra::Base comes into play:
  #
  class Server < Sinatra::Base
    set :views, 'lib/views'

    
    get '/' do
      erb :index
    end

    get '/sources/new' do
      erb 'sources/new'.to_sym
    end

    post '/sources/' do
      # redirect to('/')
      # 1) create a source instance
      source = Source.new(params)
      # 2) save it
      # if source.valid?
      #   source.save
      #   status 200
      # elsif source.nonunique?
      #   status 403
      # else
      #   status 400
      # end
      # 3a) if the request contains the required parameters and is unique, then return 200OK
      # 3b) if it contains the required parameters, but isn't unique then return 403
      # 3c) otherwise return 400 Bad request
      
    end

    not_found do
      erb :error
    end
  end

end