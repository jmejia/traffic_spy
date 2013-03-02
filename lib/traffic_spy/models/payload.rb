module Payload
  
  def initialize
    @payload_db = Sequel.sqlite('./db/...')
  end

  def self.database

  post '/x/data' do
  #1) create an instance of payload that has all of the properties
    payload = Payload.new
  #2) check to see if there is a payload return status that matches the one being created
  #2a) if so, return error
  #3) store payload objects in a database
end