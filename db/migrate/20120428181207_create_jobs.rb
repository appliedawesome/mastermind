class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :target_name
      t.string :action
      t.text :profile
      
      t.references :heist

      t.timestamps
    end
    
    add_index :jobs, :heist_id
    add_index :jobs, :name
    add_index :jobs, :target_name
  end
end
