class ChangeMobileIconDefault < ActiveRecord::Migration
  def change
  	def up
	  change_column :categories, :mobile_icon, :string, default: "fa-question"
	end

	def down
	  change_column :categories, :mobile_icon, :string, default: nil
	end
  end
end
