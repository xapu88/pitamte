class QuestionsController < ApplicationController
	before_filter :question_params, :only => :create

	def create
		@question = Question.new(question_params)
		if @question.save
			redirect_to root_path, note: "Pitanje uspesno postavljeno!"
		else
			redirect_to root_path
		end
	end

	private
		def question_params
			params.require(:question).permit(:title, :content)
		end
end
