module TrafficSpy
  class Source

    attr_reader :id, :identifier, :root_url
    extend Search

    SEARCHABLES = ["identifier"]

    def initialize(input)
      @id = input[:id]
      @identifier = input[:identifier]
      @root_url = input[:root_url]
    end

    def valid?
      true unless missing_attributes?
    end

    def missing_attributes?
      [identifier, root_url].include?("")
    end

    def exists?
      Source.table.where(:identifier => identifier).to_a.count > 0
    end

    def save
      Source.table.insert(:identifier => identifier, :root_url => root_url)
    end

    def self.table
      DB.from(:sources)
    end

    def self.searchables
      @_searchables = ["identifier"]
    end

    searchables.each do |attr|
      define_singleton_method("find_by_#{attr}") do |val|
        find_by_attribute(attr, val)
      end
    end

  end
end
