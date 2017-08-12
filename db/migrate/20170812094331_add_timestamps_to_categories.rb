class AddTimestampsToCategories < ActiveRecord::Migration[5.1]
  def change
  	add_timestamps :categories
  end
end
