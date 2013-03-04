module TrafficSpy
  module Finder

    def find_by_attribute(attr, val)
      match = table.where(attr.to_sym => val).to_a.first
      new(match)
    end

    def find_or_save(attr, val)
      if exists?(attr, val)
        find_by_attribute(attr, val).id
      else
        save(val)
        find_by_attribute(attr, val).id
      end
    end

    def exists?(attr, val)
      table.where(attr.to_sym => val).to_a.count > 0
    end

    def table
      table_name = "#{name.split("::").last.downcase}s"
      DB.from(table_name.to_sym)
    end

  end
end
