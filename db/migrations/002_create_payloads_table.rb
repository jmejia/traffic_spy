Sequel.migration do
  change do
    create_table(:payloads) do
      primary_key :id
      foreign_key :source_id
      foreign_key :url_id
      DateTime    :requested_at
      Integer     :responded_in
      foreign_key :referrer_id
      String      :request_type
      foreign_key :event_id
      String      :browser
      String      :os
      String      :resolution
      String      :ip
      DateTime    :created_at
    end
  end
end



