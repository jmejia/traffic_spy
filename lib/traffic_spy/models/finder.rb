module TrafficSpy
  module Search

    def find_by_attribute(attr, val)
      klass = table.where(attr.to_sym => val).to_a.first
      puts klass.inspect
      new(klass)
    end

  end
end
