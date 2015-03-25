ActiveAdmin.register Answer do
  permit_params :content

  index do
    id_column
    column :content
    column :question do |answer|
      auto_link answer.question
    end
    column :user do |answer|
      auto_link answer.user
    end
    actions
  end
end
