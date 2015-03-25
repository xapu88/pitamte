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
end
