class CreateHeists < ActiveRecord::Migration
  def change
    create_table :heists do |t|
      t.string :name
      t.text :profile
      
      t.timestamps
    end
  end
end
