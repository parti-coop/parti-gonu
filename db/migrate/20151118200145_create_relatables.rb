class CreateRelatables < ActiveRecord::Migration
  def change
    create_table :relatables do |t|
      t.references :relating, null: false
      t.references :related, null: false, index: true
      t.timestamps null: false
    end

    add_index :relatables, [:relating_id, :related_id], unique: true
  end
end
