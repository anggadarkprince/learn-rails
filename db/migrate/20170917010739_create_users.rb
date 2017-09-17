class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :username, null: false, limit: 30, unique: true
      t.string :email, null: false, limit: 50, unique: true
      t.string :password, null: false, limit: 200
      t.string :avatar, limit: 300
      t.string :about, limit: 500
      t.string :role, default: 'writer'
      t.timestamps
    end
  end
end
