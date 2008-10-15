migration 4, :create_tags  do
  up do
    create_table :tags do
      column :id, Serial
      column :name, String
    end
  end
  
  down do
    drop_table :tags
  end
end
