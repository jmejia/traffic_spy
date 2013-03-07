module TrafficSpy
  class Url

    extend Finder

    attr_reader :id, :full_url, :requests, :path, :source_id

    def initialize(input)
      @id = input[:id]
      @full_url = input[:full_url]
      @requests = input[:requests]
      @source_id = input[:source_id]
      @path = input[:path]
    end

    def self.save(url, source_id)
      Url.table.insert(:full_url => url,
                       :path => URI(url).path[1..-1],
                       :source_id => source_id,
                       :requests => 1
                      )
    end

    def self.searchables
      @_searchables = ["url", "id", "requests"]
    end

    def self.exists?(attr, val)
      table.where(attr.to_sym => val).to_a.count > 0
    end

    def update_requests
      count = requests + 1
      Url.table.where(:id => id).update(:requests => count)
    end

    def payloads
      @payloads ||= Payload.find_all_by_attribute("url_id", id, { order: :responded_in })
    end

    def avg_response_time
      total_time = payloads.inject(0) do |sum, payload|
        sum + payload.responded_in
      end
      @avg_response_time = total_time / payloads.count
    end

    def self.find_or_save(attr, val, source_id)
      if exists?(attr, val)
        url = find_by_attribute(attr, val)
        url.update_requests
        url.id
      else
        save(val, source_id)
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
