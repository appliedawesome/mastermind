class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :target
      t.string :action
      t.references :heist

      t.timestamps
    end
    
    add_index :jobs, :heist_id
    add_index :jobs, :name
  end
end
