class RemoveTimestampsFromCategories < ActiveRecord::Migration[5.1]
  def change
  	remove_column :categories, :timestamps
  end
end
