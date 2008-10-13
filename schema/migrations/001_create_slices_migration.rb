migration 1, :create_slices  do
  up do
    create_table :slices do
      column :id, Serial
      column :name, String
      column :source, String
      column :user_id, Integer
      column :last_commit_at, DateTime
      column :description, Text
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end
  
  down do
    drop_table :slices
  end
end
