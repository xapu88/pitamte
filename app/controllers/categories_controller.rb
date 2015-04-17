class CategoriesController < ApplicationController
	before_action :get_category, only: [:show]

	def show
		@categories = Category.all
		@questions = Question.where("category_id = ?", @category.id)
		@question = Question.new
	end

	private
		def get_category
			@category = Category.find(params[:id])
		end
end
