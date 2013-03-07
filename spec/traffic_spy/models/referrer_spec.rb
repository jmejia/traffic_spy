require 'spec_helper'

describe TrafficSpy::Referrer do
  context "saving" do
    let (:referrer) {{:url => "http://jumpstartlab.com/users"}}
    it "inserts info into table" do
      count = TrafficSpy::Referrer.table.count
      described_class.save("http://jumpstartlab.com/users")
      expect(TrafficSpy::Referrer.table.count).to eq(count + 1)
    end
  end

  context "searchable" do
    it "searches by url" do
      referrer = described_class.table.count
      referrer = described_class.find_by_url("http://jumpstartlab.com/users")
      expect(referrer.url).to eq("http://jumpstartlab.com/users")
    end
  end

  context "find or save" do
    it "Returns the ID if record exists" do
      return_id = described_class.find_or_save("url", "http://jumpstartlab.com/users")
      expect(return_id).to eq(7)
    end
  end
end
