
module TrafficSpy
  class Payload
    def initialize(input)
      @payload           = input[:payload]
      @url               = input[:url]
      @requested_at      = input[:requested_at]
      @responded_in      = input[:responded_in]
      @referred_by       = input[:referred_by]
      @request_type      = input[:request_type]
      @parameters        = input[:parameters]
      @event_name        = input[:event_name]
      @user_agent        = input[:user_agent]
      @resolution_width  = input[:resolution_width]
      @resolution_height = input[:resolution_height]
    end

    def self.table
      DB.from(:payloads)
    end

    def save(identifier, payload)
      Payload.table.insert(
        :url => url,
        :requested_at => requested_at
        :responded_in => responded_in
        :referred_by => referred_by
        :request_type => request_type
        :paramters => parameters
        :event_name => event_name
        :user_agent => user_agent
        :resolution_width => resolution_width
        :resolution_height => resolution_height
        )
      end
    end

  end
end