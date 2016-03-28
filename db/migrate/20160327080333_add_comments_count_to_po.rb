class AddCommentsCountToPo < ActiveRecord::Migration
  def change
    add_column :pos, :comments_count, :integer, :default => 0

    Po.pluck(:id).each do |i|
      Po.reset_counters(i, :comments)
    end
  end
end
