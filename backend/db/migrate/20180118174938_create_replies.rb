class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.integer :value
      t.text :note
      t.references :sendee, foreign_key: true
      t.references :sub_request, foreign_key: true

      t.timestamps
    end
  end
end
