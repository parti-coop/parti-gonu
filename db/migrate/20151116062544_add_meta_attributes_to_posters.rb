class AddMetaAttributesToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :title, :text
    add_column :posters, :description, :text
    add_column :posters, :image, :string
  end
end
