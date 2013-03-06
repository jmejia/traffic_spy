Sequel.migration do
  change do
    create_table :urls do
      primary_key :id
      String      :full_url
      integer     :requests
      String      :path
      foreign_key :source_id
    end
  end
end
