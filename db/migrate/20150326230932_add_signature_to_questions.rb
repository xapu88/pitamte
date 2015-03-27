class AddSignatureToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :signature, :string
  end
end
