class ChangeCategoryPositionDefault < ActiveRecord::Migration
  def change
  	def up
	  change_column :categories, :position, :integer, default: 0
	end

	def down
	  change_column :categories, :position, :integer, default: nil
	end
  end
end
