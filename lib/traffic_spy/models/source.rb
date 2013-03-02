module TrafficSpy
  class Source

    attr_reader :id, :identifier, :root_url

    def initialize(input)
      @id = input[:id]
      @identifier = input[:identifier]
      @root_url = input[:rootUrl]
    end

    def valid?
      true unless missing_attributes?
    end

    def missing_attributes?
      [identifier, root_url].include?("")
    end

    def exists?
      sources_table.where(:identifier => identifier).to_a.count > 0
    end

    def sources_table
      DB.from(:sources)
    end

    def save
      sources_table.insert(:identifier => identifier, :root_url => root_url)
    end
  end
end
