require 'spec_helper'

  describe TrafficSpy::Payload do 

    context "Loading and Parsing" do

      let (:sample_input) do
        {
          "url" => "http://jumpstartlab.com/blog",
          "requestedAt" => "2013-02-16 21:38:28 -0700",
          "respondedIn" => 37,
          "referredBy" => "http://jumpstartlab.com",
          "requestType" => "GET",
          "parameters" => [],
          "eventName" => "socialLogin",
          "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight" => "1280",
          "ip" => "63.29.38.211"
        }
      end

      let (:sample_site) do
          { :url_id => 1, :source_id => 1, :requested_at => "2013-02-17 12:34:43 -0700", :referrer_id => 2,
          :responded_in => "42", :request_type => "GET", :parameters => "[]", :event_id => 3, :browser => "Chrome",
          :os => "Intel Mac OS X 10_8_2", :resolution => "1920 x 1280", :ip => "63.29.38.211", :created_at => Time.now} 
      end

      describe ".new" do
        it 'allows creation of a new instance' do
          payload = described_class.new(sample_site)
          expect(payload.requested_at).to eq("2013-02-17 12:34:43 -0700")
        end
      end

      describe 'payload.save (instance method)' do
        it 'persists a record to the database and populates the id' do
          count = described_class.table.count
          described_class.save("jumpstartlab", sample_input)
          expect(described_class.table.count).to eq(count + 1)
        end
      end

    end
  end

