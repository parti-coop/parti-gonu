class RemoveStandChoiceCountsToPosters < ActiveRecord::Migration
  def change
    remove_column :posters, :stand_actively_support_count, :integer, null: false, default: 0
    remove_column :posters, :stand_block_count, :integer, null: false, default: 0
    remove_column :posters, :stand_oppose_count, :integer, null: false, default: 0
    remove_column :posters, :stand_in_favor_count, :integer, null: false, default: 0
  end
end
