Sequel.migration do
  change do
    create_table(:sources) do
      primary_key   :id
      String        :identifier
      String        :root_url
    end
  end
end
