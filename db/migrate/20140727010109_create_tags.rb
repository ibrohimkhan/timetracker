class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :task, index: true
      t.references :label, index: true

      t.timestamps
    end
  end
end
