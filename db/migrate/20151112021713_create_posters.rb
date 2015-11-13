class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.string :url, null: false, index: true
      t.references :user, null: false, index: true
      t.timestamps null: false
    end
  end
end
