module TrafficSpy

  if ENV["TRAFFIC_SPY_ENV"] == "test"
    database_file = 'db/traffic_spy-test.sqlite3'
    DB = Sequel.sqlite database_file
  else
    DB = Sequel.postgres "traffic_spy"
  end

end

require 'useragent'
require 'uri'

require 'traffic_spy/models/finder'
require 'traffic_spy/models/source'
require 'traffic_spy/models/payload'
require 'traffic_spy/models/url'
require 'traffic_spy/models/referrer'
require 'traffic_spy/models/event'
