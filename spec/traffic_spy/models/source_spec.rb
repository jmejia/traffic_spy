require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Source do
    context "Creating" do
      let (:subject) { described_class }
      it "can save parameters to /sources" do
        params = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
        #source = subject.new(params)
        subject.should_receive(:save).with(params).and_return(true)
        expect(source.identifier).to eq "jumpstartlab"
      end
    end
  end
end
