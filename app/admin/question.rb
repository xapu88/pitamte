ActiveAdmin.register Question do
  permit_params :title, :content, :category_id

end
