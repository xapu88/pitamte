ActiveAdmin.register Question do
  permit_params :title, :content, :category_id


  index do
    id_column
    column :title
    column :content
    column :user do |question|
      auto_link question.user
    end
    actions
  end
end
