class QuestionsController < ApplicationController
	before_filter :get_category, only: [:create]

	def create
		@question = @category.questions.build(question_params)
		if @question.save
			redirect_to root_path, note: "Pitanje uspesno postavljeno!"
		else
			redirect_to root_path, alert: "GRESKA! Niste ispravno uneli pitanje."
		end
	end

	private
		def question_params
			params.require(:question).permit(:title, :content, :category_id)
		end

		def get_category
			@category = Category.find(params[:question][:category_id])
		end
end
