migration 5, :create_taggings  do
  up do
    create_table :taggings do
      column :id, Serial
      column :tag_id, Integer
      column :slice_id, Integer
      column :user_id, Integer
    end
  end
  
  down do
    drop_table :taggings
  end
end
