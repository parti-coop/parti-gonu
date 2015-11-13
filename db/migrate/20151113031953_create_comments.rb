class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :version, null: false, index: true
      t.timestamps null: false
    end

    remove_column :versions, :comment, :text
  end
end
