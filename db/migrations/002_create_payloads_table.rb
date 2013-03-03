Sequel.migration do
  change do
    create_table(:payloads) do
      primary_key :id
      String      :url
      String      :source
      DateTime    :requested_at
      Integer     :responded_in
      String      :referred_by
      String      :request_type
      String      :parameter
      String      :event
      String      :user_agent
      String      :resolution
      String      :ip
    end
  end
end



