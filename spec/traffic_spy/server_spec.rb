require 'spec_helper'

describe TrafficSpy::Server do
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  let(:random_string) {(0...10).map{ ('a'..'z').to_a[rand(26)] }.join}

  describe "/sources" do

    describe "application registration at /sources" do
      context "given valid and unique parameters" do
        it "registers the application" do
          #random_string = (0...10).map{ ('a'..'z').to_a[rand(26)] }.join
          post "/sources", {"identifier" => random_string, "rootUrl" => 'http://fakeurl.com'}
          expect(last_response).to be_ok
          expect(last_response.body.downcase).to include("identifier")
        end
      end
    end

    context "given parameters for an already existing application" do
      it "returns an error" do
        2.times { post "/sources", {"identifier" => 'jumpstartlab', "rootUrl" => 'http://jumpstartlab.com'} }
        expect(last_response.status).to eq 403
      end
    end

    context "given parameters are missing" do
      it "returns an error" do
        post "/sources", {"identifier" => 'testtest'}
        expect( last_response.status ).to eq 400
      end
    end
  end

  describe "/sources/:identifier/data" do

    context "with a payload" do
      let(:payload) do
          {"url"            => "http://jumpstartlab.com/blog",
          "requestedAt"     => random_string,
          "respondedIn"     => 37,
          "referredBy"      => "http://jumpstartlab.com",
          "requestType"     => "GET",
          "parameters"      => [],
          "eventName"       => "socialBtn",
          "userAgent"       => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)"+
          " AppleWebKit/537.17 (KHTML, like Gecko) "+
          "Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight"=> "1280",
          "ip"              => "63.29.38.211"}.to_json
      end

      let(:payload2) do
          {"url"            => "http://jumpstartlab.com/blog",
          "requestedAt"     => "2013-03-06",
          "respondedIn"     => 37,
          "referredBy"      => "http://jumpstartlab.com",
          "requestType"     => "GET",
          "parameters"      => [],
          "eventName"       => "socialBtn",
          "userAgent"       => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)"+
          " AppleWebKit/537.17 (KHTML, like Gecko) "+
          "Chrome/24.0.1309.0 Safari/537.17",
          "resolutionWidth" => "1920",
          "resolutionHeight"=> "1280",
          "ip"              => "63.29.38.211"}.to_json
      end

      before do
        if TrafficSpy::Source.find_by_identifier("jumpstartlab").nil?
          client = TrafficSpy::Source.new(:identifier => "jumpstartlab",
                                          :rooturl    => "http://jumpstartlab.com")
          client.save
        end
      end

      it "creates the payload" do
        post "/sources/jumpstartlab/data", payload: payload
        expect(last_response.status).to eq 200
      end

      it "returns 403 if payload exists" do
        post '/sources/jumpstartlab/data', payload: payload2
        post '/sources/jumpstartlab/data', payload: payload2
        expect(last_response.status).to eq 403
      end
    end
  end

end
