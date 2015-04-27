class CategoriesController < ApplicationController
	before_action :get_category, only: [:show]

	def show
		@categories = Category.all
		@questions = Question.where("category_id = ?", @category.id).page(params[:page])
		@question = Question.new
		if request.path != category_path(@category)
			redirect_to @category, status: :moved_permanently
		end
	end

	private
		def get_category
			@category = Category.friendly.find(params[:id])
		end
end
