class AddSignatureToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :signature, :string
  end
end
