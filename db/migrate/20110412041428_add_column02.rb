class AddColumn02 < ActiveRecord::Migration
  def self.up
    add_column :list_items, :complete_date, :date
    add_column :list_items, :status, :string
  end

  def self.down
  end
end
