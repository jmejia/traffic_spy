require 'json'

module Payload
  
  def initialize
    @payload_db = Sequel.sqlite('./db/...')
  end

  def self.database

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