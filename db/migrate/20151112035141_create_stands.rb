class CreateStands < ActiveRecord::Migration
  def change
    create_table :stands do |t|
      t.references :user, null: false, index: true
      t.references :poster, null: false
      t.timestamps null: false
    end

    add_index :stands, [:poster_id, :user_id], unique: true
  end
end
