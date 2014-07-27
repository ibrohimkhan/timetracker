class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :parent_id, :default => 0
      t.boolean :state, :default => false

      t.timestamps
    end
  end
end
