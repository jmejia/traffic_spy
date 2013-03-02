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

    post '/sources' do
      clean_hash = { :identifier => params[:identifier],
                     :root_url   => params[:rootUrl]
                   }
      source = Source.new(clean_hash)

      if source.exists?
        status 403
        body "Identifier already exists."
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
