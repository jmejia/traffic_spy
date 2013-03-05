module TrafficSpy
  class Url

    extend Finder
    attr_reader :id, :url, :requests

    def initialize(input)
      @id = input[:id]
      @url = input[:url]
      @requests = input[:requests]
    end

    def self.save(url)
      Url.table.insert(:url => url, :requests => 1)
    end

    def self.searchables
      @_searchables = ["url", "id", "requests"]
    end

    def update_requests
      count = requests + 1
      Url.table.where(:id => id).update(:requests => count)
    end

    def self.find_or_save(attr, val)
      if exists?(attr, val)
        url = find_by_attribute(attr, val)
        url.update_requests
        url.id
      else
        save(val)
        find_by_attribute(attr, val).id
      end
    end

    searchables.each do |attr|
      define_singleton_method("find_by_#{attr}") do |val|
        find_by_attribute(attr, val)
      end
    end
  end
end
