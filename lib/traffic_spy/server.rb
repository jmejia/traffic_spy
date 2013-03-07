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
        response 404
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

    get '/sources/:identifier/events/?' do
      identifier = params[:identifier]
      if Source.exists?("identifier", identifier)
        @source = Source.find_by_identifier(identifier)
        events = @source.events
        @events = events.sort_by { |event| -event.received_count }
        erb 'events/index'.to_sym
      else
        body "Whoa, buddy... That's **NOT** a valid Identifier"
      end
    end

    get '/sources/:identifier/events/:event_name/?' do
      identifier = params[:identifier]
      event_name = params[:event_name]
      if Source.exists?("identifier", identifier)
        @source = Source.find_by_identifier(identifier)
        if Event.exists?("name", params[:event_name])
          @event = Event.find_by_attribute("name", event_name)
          @payloads = @event.payloads.group_by { |payload| payload.requested_at.hour }
          erb 'events/show'.to_sym
        else
          @message = "Event not defined"
          @link = {:text => "Events Index", :link => "/sources/#{@source.identifier}/events"}
          erb :invalid_info
        end
      else
        body "Whoa, buddy... That's **NOT** a valid Identifier"
      end
    end

    post '/sources/:identifier/data' do
      if Source.exists?("identifier", params[:identifier])
        data = JSON.parse(params[:payload])
        if Payload.exists?(data)
          body "Duplicate payload"
          status 403
        else
          Payload.save(params[:identifier], data)
          status 200
        end
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
