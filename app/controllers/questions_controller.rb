class QuestionsController < ApplicationController
	before_filter :get_category, only: [:create]
	before_filter :get_question, except: [:create]
	before_action :authenticate_user!, except: [:create]
	after_action :verify_authorized, except: [:index, :show, :new, :create]

	def show
		@answer = Answer.new
		@answers = @question.answers
	end

	def create
		@question = @category.questions.build(question_params)
		@question.user = current_user if user_signed_in?
		respond_to do |format|
			if @question.save
				format.html { redirect_to root_path, note: "Pitanje uspesno postavljeno!" }
				format.js {}
			else
				format.html { redirect_to root_path, alert: "GRESKA! Niste ispravno uneli pitanje." }
			end
		end
	end

	def edit
		authorize @question
	end

	def update
		@question.update(question_params)
		authorize @question
		if @question.save
			redirect_to my_questions_path
		else
			redirect_to edit_question_path(@question)
		end
	end

	def destroy
		authorize @question
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
