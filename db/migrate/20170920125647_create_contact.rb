class CreateContact < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 50
      t.string :subject, null: false, limit: 100
      t.text :message, null: false, limit: 50, unique: true
      t.timestamps
    end
  end
end
