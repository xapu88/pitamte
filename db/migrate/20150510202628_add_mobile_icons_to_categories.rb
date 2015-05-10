class AddMobileIconsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :mobile_icon, :string
  end
end
