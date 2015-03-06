class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :categories
    add_foreign_key :questions, :users
    add_index :questions, [:user_id, :category_id, :created_at]
  end
end
