module TrafficSpy
  class Payload

    extend Finder

    attr_reader :url_id, :event_id, :os, :browser, :resolution, :responded_in, :url, :event, :requested_at

    def initialize(input)
      @url_id            = input[:url_id]
      @source_id         = input[:source_id]
      @requested_at      = input[:requested_at]
      @responded_in      = input[:responded_in]
      @referrer_id       = input[:referred_by]
      @request_type      = input[:request_type]
      @parameters        = input[:parameters]
      @event_id          = input[:event_id]
      @os                = input[:os]
      @browser           = input[:browser]
      @resolution        = input[:resolution]
    end

    def self.table
      DB.from(:payloads)
    end

    def self.save(identifier, params)
      source = Source.find_by_identifier(identifier)
      return false unless source
      source_id = source.id

      user_agent = UserAgent.parse(params["userAgent"])
      width = params["resolutionWidth"]
      height = params["resolutionHeight"]

      Payload.table.insert(
        :url_id => Url.find_or_save("full_url", params["url"], source_id),
        :source_id => source_id,
        :requested_at => params["requestedAt"],
        :responded_in => params["respondedIn"],
        :referrer_id => Referrer.find_or_save("url", params["referredBy"]),
        :request_type => params["requestType"],
        :event_id => Event.find_or_save("name", params["eventName"], source_id),
        :browser => user_agent.browser,
        :os => user_agent.os,
        :resolution => "#{width}x#{height}",
        :ip => params["ip"]
      )
      self
    end

    def save
      @id = self.class.table.insert(
        :url_id => url_id,
        :source_id => source_id,
        :requested_at => requested_at,
        :responded_in => responded_in,
        :referrer_id => referrer_id,
        :request_type => request_type,
        :event_id => event_id,
        :browser => browser,
        :os => os,
        :resolution => resolution,
        :ip => ip,
        :created_at => Time.now
      )
      self
    end

    def new_record?
      requested_at.nil?
    end

    def url
      @url = Url.find_by_attribute("id", url_id)
    end

    def url
      @url = Url.find_by_attribute("id", url_id)
    end

    def event
      @event = Event.find_by_attribute("id", event_id)
    end

  end
end
