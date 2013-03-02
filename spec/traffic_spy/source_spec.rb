require 'spec_helper'

describe TrafficSpy::Source do
  context "Creating" do
    it "can save parameters to /sources" do
      params = "identifier=jumpstartlab&rootUrl=http://jumpstartlab.com"
      source = Source.new(params)
      expect(source.identifier).to eq "jumpstartlab"
    end
  end
end
