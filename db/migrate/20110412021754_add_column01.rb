class AddColumn01 < ActiveRecord::Migration
  def self.up
    add_column :list_items, :expected_date, :date
  end

  def self.down
  end
end
