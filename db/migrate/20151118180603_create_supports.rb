class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.references :stand, null: false
      t.references :target, null: false, index: true
      t.timestamps null: false
    end

    add_index :supports, [:stand_id, :target_id], unique: true
  end
end
