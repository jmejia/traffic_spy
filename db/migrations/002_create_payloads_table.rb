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
      foreign_key :user_agent_id
      String      :resolution
      foreign_key :ip_id
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end



