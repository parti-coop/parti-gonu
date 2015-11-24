class AddTagsToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :tags, :string, length: 500
  end
end
