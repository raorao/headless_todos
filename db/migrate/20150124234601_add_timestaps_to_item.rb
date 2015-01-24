class AddTimestapsToItem < ActiveRecord::Migration
  def change
    add_column :items, :created_at, :datetime
    add_column :items, :updated_at, :datetime
  end
end
