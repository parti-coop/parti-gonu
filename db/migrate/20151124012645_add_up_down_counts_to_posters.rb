class AddUpDownCountsToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :up_count, :integer, default: 0
    add_column :posters, :down_count, :integer, default: 0
  end
end
