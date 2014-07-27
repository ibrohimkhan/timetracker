class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :task
      t.string :file_path, :null => false

      t.timestamps
    end
  end
end
