  require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Event do
  
    context "Saving" do
      let (:subject) {described_class}
      let (:sample_site) { {:name => "promo", :source_id => 1, :received_count => 3} }

      # describe ".update_received_count" do
      #   it "increments count of requests per event" do
      #     event = subject.new(sample_site)
      #     subject.find_or_save("name", event.name, event.id)
      #     expect(event.received_count).to eq(4)
      #   end
      # end

      describe ".save" do
        it "inserts the data into each individual table" do
        event = subject.new(sample_site)
        subject.save("promo", 1)
        expect(event.name).to eq("promo")
        end
      end

      # describe ".searchables" do
      #   it "can " do
      #   event = subject.new(sample_site)
      #   expect(event.find_by_name).to eq("promo")
      #   end
      # end

      

    end

  end
end