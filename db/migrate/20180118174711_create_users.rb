class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :staff_id_mb
      t.string :first_name
      t.string :last_name
      t.string :login_location
      t.string :email
      t.integer :mobile_phone
      t.integer :home_phone
      t.integer :work_phone

      t.timestamps
    end
  end
end
