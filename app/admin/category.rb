ActiveAdmin.register Category do
  permit_params :title

  controller do
  	before_action :get_category, only: [:edit, :update]

  	def create
	    create! do |format|
	      format.html { redirect_to admin_categories_path }
	    end
	  end

	  def update
	    update! do |format|
	      format.html { redirect_to admin_categories_path }
	    end
	  end

	  private
	  	def get_category
				@category = Category.friendly.find(params[:id])
			end
	end

end
