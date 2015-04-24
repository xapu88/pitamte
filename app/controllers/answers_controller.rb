class AnswersController < ApplicationController
	before_filter :get_question, only: [:create]
	before_filter :get_answer, only: [:edit, :update, :destroy, :vote]
	before_action :authenticate_user!
	after_action :verify_authorized, except: [:index, :show, :new, :create, :vote]

  def create
		@answer = @question.answers.build(answer_params)
		@answer.question_id = @question.id
		@answer.user = current_user
		if params[:sign] == "1"
			if current_user.username.nil?
				current_user.username = params[:username]
				current_user.save!
			end
			@answer.signature = current_user.username
		end
		if @answer.save
			redirect_to question_path(@question.id), note: "Odgovor uspesno postavljen!"
		else
			redirect_to question_path(@question.id), alert: "GRESKA! Niste ispravno uneli odgovor."
		end
	end

	def edit
		authorize @answer
	end

	def update
		@answer.update(answer_params)
		authorize @answer
		if @answer.save
			redirect_to my_answers_path
		else
			redirect_to edit_answer_path(@answer)
		end
	end

	def destroy
		authorize @answer
		@answer.destroy
		respond_to do |format|
			format.js {}
		end
	end

	def vote
		value = params[:type] == "up" ? 1 : -1
		@answer.add_or_update_evaluation(:votes, value, current_user)
		redirect_to :back, notice: "Hvala što glasate!"
	end

	private
		def answer_params
			params.require(:answer).permit(:content)
		end

		def get_answer
			@answer = Answer.find(params[:id])
		end

		def get_question
			@question = Question.find(params[:answer][:question_id])
		end
end
