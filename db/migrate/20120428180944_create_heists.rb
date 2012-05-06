class CreateHeists < ActiveRecord::Migration
  def change
    create_table :heists do |t|
      t.string :name
      t.text :profile, :default => {}.to_json
      
      t.timestamps
    end
  end
end
