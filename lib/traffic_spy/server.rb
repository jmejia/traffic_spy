require 'json'
module TrafficSpy

  class Server < Sinatra::Base
    set :views, 'lib/views'
    set :public_folder, 'lib/public'

    get '/' do
      erb :index
    end

    get '/sources/new' do
      erb 'sources/new'.to_sym
    end

    get '/sources/:identifier/?' do
      identifier = params[:identifier]
      if Source.exists?("identifier", identifier)
        @source = Source.find_by_identifier(identifier)
        @payloads = @source.payloads.reverse
        urls = @source.urls
        @requested_urls = urls.sort_by { |url| -url.requests }
        @response_urls = urls.sort_by { |url| -url.avg_response_time }

        erb 'sources/show'.to_sym
      else
        body "Identifier does not exist"
      end
    end

    get '/sources/:identifier/urls/*/?' do
      identifier = params[:identifier]
      path = params[:splat]
      if Source.exists?("identifier", identifier)
        @source = Source.find_by_identifier(identifier)
        full_url = "#{@source.root_url}/#{path[0]}"
        if Url.exists?("full_url", full_url)
          @url = Url.find_by_attribute("full_url", full_url)
          @payloads = @url.payloads.reverse
          erb 'urls/show'.to_sym
        else
          body "This URL has not been requested"
        end
      else
        body "Whoa, buddy... That's **NOT** a valid Identifier"
      end
    end

    post '/sources/:identifier/data' do
      if Source.exists?("identifier", params[:identifier])
        data = JSON.parse(params[:payload])
        Payload.save(params[:identifier], data)
        status 200
      else
        body "Identifier does not exist"
        status 400
      end
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
