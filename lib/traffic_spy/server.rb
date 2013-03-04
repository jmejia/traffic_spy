require 'json'
module TrafficSpy

  class Server < Sinatra::Base
    set :views, 'lib/views'


    get '/' do
      erb :index
    end

    get '/sources/new' do
      erb 'sources/new'.to_sym
    end

    get '/sources/:identifier' do
      @source = Source.find_by_identifier(params[:identifier])
      erb 'sources/show'.to_sym
    end

    post '/sources/:identifier/data' do
      data = JSON.parse(params[:payload])
      Payload.save(params[:identifier], data)
      status 200
    end

    post '/sources' do
      clean_params = Source.clean(params)
      source = Source.new(clean_params)

      if source.exists?
        status 403
      elsif source.valid?
        source.save
        status 200
        body "{\"identifier\":\"#{source.identifier}\"}"
      else
        status 400
        body "Missing required parameters."
      end
    end

    not_found do
      erb :error
    end
  end

end
