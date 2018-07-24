class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.belongs_to :user, foreign_key: true
      t.string :type
      t.string :state

      t.timestamps
    end
  end
end
