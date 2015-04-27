ActiveAdmin.register Question do
  permit_params :title, :content, :category_id, :approved


  index do
    id_column
    column :title
    column :content
    column :user do |question|
      auto_link question.user
    end
    column :approved
    actions
  end

  controller do
    before_action :get_question, only: [:edit, :update]

    def create
      create! do |format|
        format.html { redirect_to admin_questions_path }
      end
    end

    def update
      update! do |format|
        format.html { redirect_to admin_questions_path }
      end
    end

    private
      def get_question
        @question = Question.friendly.find(params[:id])
      end
  end
end
