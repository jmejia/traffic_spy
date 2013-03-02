module TrafficSpy
  class Source

    attr_reader :id, :identifier, :root_url

    def initialize(input)
      @id = input[:id]
      @identifier = input[:identifier]
      @root_url = input[:rootUrl]
    end

    def valid?

    end

    def save
      DB.from(:sources).insert(:identifier => identifier, :root_url => root_url)
    end
  end
end
