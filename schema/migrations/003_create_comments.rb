migration 3, :create_users  do
  up do
    create_table :comments do
      column :id, Serial
      column :user_id, Integer
      column :slice_id, Integer
      column :body, Text
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end
  
  down do
    drop_table :comments
  end
end
