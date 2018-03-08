class CreateSelectedSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :selected_subs do |t|
      t.boolean :confirmed
      t.references :sub_request, foreign_key: true
      t.references :sendee, foreign_key: true
      t.timestamps
    end
  end
end
