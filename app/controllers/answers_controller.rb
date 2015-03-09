class AnswersController < ApplicationController
	before_filter :get_question, only: [:create]

  def create
		@answer = @question.answers.build(answer_params)
		if @answer.save
			redirect_to question_path(@question.id), note: "Odgovor uspesno postavljen!"
		else
			redirect_to question_path(@question.id), alert: "GRESKA! Niste ispravno uneli odgovor."
		end
	end

	private
		def answer_params
			params.require(:answer).permit(:content, :question_id)
		end

		def get_question
			@question = Question.find(params[:answer][:question_id])
		end
end
