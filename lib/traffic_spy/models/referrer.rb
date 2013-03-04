module TrafficSpy
  class Referrer

    attr_reader :id, :url
    extend Finder

    def initialize(input)
      @id = input[:id]
      @url = input[:url]
    end

    def self.save(url)
      table.insert(:url => url)
    end

    def self.searchables
      @_searchables = ["url", "id"]
    end

    searchables.each do |attr|
      define_singleton_method("find_by_#{attr}") do |val|
        find_by_attribute(attr, val)
      end
    end
  end
end
