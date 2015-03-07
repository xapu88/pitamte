class QuestionsController < ApplicationController
	before_filter :get_category, only: [:create]
	before_filter :get_question, only: [:destroy]

	def create
		@question = @category.questions.build(question_params)
		respond_to do |format|
			if @question.save
				format.html { redirect_to root_path, note: "Pitanje uspesno postavljeno!" }
				format.js {}
			else
				format.html { redirect_to root_path, alert: "GRESKA! Niste ispravno uneli pitanje." }
			end
		end
	end

	def destroy
		@question.destroy
		respond_to do |format|
			format.js {}
		end
	end

	private
		def question_params
			params.require(:question).permit(:title, :content, :category_id)
		end

		def get_question
			@question = Question.find(params[:id])
		end

		def get_category
			@category = Category.find(params[:question][:category_id])
		end
end
