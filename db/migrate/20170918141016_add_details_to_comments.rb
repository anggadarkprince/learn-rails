class AddDetailsToComments < ActiveRecord::Migration[5.1]
  def change
    change_table :comments do |t|
      t.rename :commenter, :name
      t.rename :body, :comment
      t.string :email, limit: 50, after: :name
      t.string :status, limit: 100, default: 'approved', after: :comment, null: false
      t.integer :votes, default: 0, after: :status, null: false
      t.references :user, foreign_key: true, optional: true, after: :votes
      t.references :comment, foreign_key: true, optional: true, after: :votes
    end

    def up
      change_column :comments, :name, :string, :limit => 100
    end

    def down
      change_column :comments, :name, :string, :limit => 255
    end

    change_column_null :comments, :name, false
    change_column_null :comments, :comment, false
  end
end
