require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Event do
  
    context "Saving" do
      let (:subject) {described_class}
      let (:sample_site) {{:name => "promo", :source_id => 1, :received_count => 3}}

      describe ".update_received_count" do
        it "increments count of requests per event" do
        count = received_count
        event = subject.new(sample_site)
        expect(subject.count).to eq(:received_count + 1)
        end
      end

      describe ".save" do
        it "inserts the data into each individual table" do
        event = subject.save(sample_site)
        # event = subject.new(event)
        expect(:name).to eq("promo")
        end
      end

      describe ".searchables" do
        it "has an array full of searchable criteria" do
        event = subject.new(sample_site)
        expect(@_searchables[0]).to eq("id")
        end
      end

      

    end

  end
end