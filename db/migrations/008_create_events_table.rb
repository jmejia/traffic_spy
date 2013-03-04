Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id
      String      :name
      foreign_key :source_id
      integer     :received_count
    end
  end
end
