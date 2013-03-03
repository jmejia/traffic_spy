module TrafficSpy
  class Url

    def initialize(input)
      @id = input[:id]
      @url = input[:url]
    end

    def self.search_or_create(url)
      if Url.exists?
        #Url.find_by_url(url)[:id]
        Url.find_by_url(url).id
      else
        Url.save
        Url.find_by_url(url).id
      end
    end

    def self.exists?
      Url.find_by_url(url)
    end

    def self.searchables
      @_searchables = ["url"]
    end

    searchables.each do |attr|
      define_singleton_method("find_by_#{attr}") do |val|
        find_by_attribute(attr, val)
      end
    end
  end
end
