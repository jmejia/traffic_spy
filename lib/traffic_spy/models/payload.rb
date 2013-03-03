require 'json'

module TrafficSpy
  class Payload
    def initialize
      @payload      = input[:payload]
      @url          = input[:url]
      @requested_at = input[:requested_at]
      @responded_in = input[:responded_in]
      @referred_by  = input[:referred_by]
      @request_type = input[:request_type]
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
      DB.from(:payload).insert(
        :url 
        :requested_at
        :responded_in
        :referred_by
        :request_type
        :paramters
        :event_name
        :user_agent
        :resolution_width
        :resolution_height 
        )
      end


    post '/:identifier/data' do
    #1) create an instance of payload that has all of the properties as an array
      info = File.read('payload.json')
      payload = JSON.parse(info)
    #2) check to see if there is a payload return status that matches the one being created
      if payload.empty?
    #2a) if so, return error
        return 400 Bad Request
    #3) store payload objects in a database
      else

  end
end