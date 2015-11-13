class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :choice, null: false
      t.text :comment
      t.references :stand, null: false, index: true
      t.references :previous, index: true
      t.timestamps null: false
    end
  end
end
