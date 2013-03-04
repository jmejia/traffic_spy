Sequel.migration do
  change do
    create_table(:referrers) do
      primary_key :id
      String      :url
    end
  end
end
