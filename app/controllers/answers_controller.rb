class AnswersController < ApplicationController
	before_filter :get_question, only: [:create]
	before_filter :get_answer, only: [:destroy]

  def create
		@answer = @question.answers.build(answer_params)
		if @answer.save
			redirect_to question_path(@question.id), note: "Odgovor uspesno postavljen!"
		else
			redirect_to question_path(@question.id), alert: "GRESKA! Niste ispravno uneli odgovor."
		end
	end

	def destroy
		@answer.destroy
		respond_to do |format|
			format.js {}
		end
	end

	private
		def answer_params
			params.require(:answer).permit(:content, :question_id)
		end

		def get_answer
			@answer = Answer.find(params[:id])
		end

		def get_question
			@question = Question.find(params[:answer][:question_id])
		end
end
