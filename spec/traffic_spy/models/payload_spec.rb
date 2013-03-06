require 'spec_helper'

  describe TrafficSpy::Payload do 

    context "Loading and Parsing" do
      before do
        TrafficSpy::Source.new(id: 1, identifier: 'jumpstartlab').save
      end

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
      let (:identifier) {"identifier"}

      
      describe "Payload.save" do
        it "takes the information in from the JSON parse and saves it to a larger payload object" do
          payload = described_class.save("jumpstartlab", sample_input)
          expect(payload.os).to eq(sample_site[:os])
        end
      end

      describe 'payload.save (instance method)' do
        before do
          @payload = described_class.new(url_id: 1)
        end

        it 'allows creation of a new, unsaved instance' do
          @payload.id.should be_nil
          @payload.should be_new_record
        end

        it 'persists a record to the database and populates the id' do
          @payload.save
          @payload.id.should_not be_nil
          @payload.should_not be_new_record
        end
      end
    end
  end

