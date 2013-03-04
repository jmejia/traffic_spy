require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Source do

    context "Creating" do
      let (:subject) { described_class }
      let (:sample_site) { {:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"} }

      describe ".new" do
        it "can initialize source" do
          source = subject.new(sample_site)
          expect(source.identifier).to eq "jumpstartlab"
        end
      end

      describe ".clean" do
        it "adds spaces and downcases keys" do
          source = subject.clean(sample_site)
          source = subject.new(source)
          expect(source.root_url).to eq("http://jumpstartlab.com")
        end
      end

      describe "#missing_attributes?" do
        it "returns true if passed empty attribute" do
          raw = {:identifier => "", :root_url => "http://jumpstartlab.com"}
          source = subject.new(raw)
          expect(source.missing_attributes?).to eq true
        end
      end

    end


  end
end
