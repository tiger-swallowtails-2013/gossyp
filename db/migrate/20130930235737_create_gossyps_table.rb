class CreateGossypsTable < ActiveRecord::Migration
  def up
    create_table :gossyps do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.timestamps

    end
  end

  def down
    drop_table :gossyps
  end
end
