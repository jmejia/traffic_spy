module TrafficSpy
  class Event

    attr_reader :id, :name, :source_id, :received_count
    extend Finder

    def initialize(input)
      @id             = input[:id]
      @name           = input[:name]
      @source_id      = input[:source_id]
      @received_count = input[:received_count]
    end

    def update_received_count
      count = received_count + 1
      Event.table.where(:id => id).update(:received_count => count)
    end

    def self.save(name, source_id)
      table.insert(:name => name, :source_id => source_id, :received_count => 1)
    end

    def self.searchables
      @_searchables = ["id", "name", "source_id", "received_count"]
    end

    def self.find_or_save(attr, val, source_id)
      if exists?(attr, val)
        event = find_by_attribute(attr, val)
        event.update_received_count
        event.id
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
