module TrafficSpy
  module Finder

    def find_by_attribute(attr, val)
      klass = name.split("::").last
      klass = table.where(attr.to_sym => val).to_a.first
      new(klass)
    end

  end
end
