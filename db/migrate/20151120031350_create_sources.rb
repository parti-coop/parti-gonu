class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :url, length: 500, null: false
      t.string :title, length: 500
      t.text :description
      t.string :image
      t.timestamps null: false
    end

    add_index :sources, :url, unique: true
    change_column_null :posters, :url, true
    add_reference :posters, :source, index: true
  end
end
