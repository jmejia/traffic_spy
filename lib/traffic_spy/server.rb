module TrafficSpy

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
      source.save
      redirect to('/')

      # 2) save it
      #if source.valid?
      #  source.save
      #  status 200
      #elsif source.nonunique?
      #  status 403
      #else
      #  status 400
      #end
      # 3a) if the request contains the required parameters and is unique, then return 200OK
      # 3b) if it contains the required parameters, but isn't unique then return 403
      # 3c) otherwise return 400 Bad request
      
    end

    not_found do
      erb :error
    end
  end

end
