class CreateResponsesTable < ActiveRecord::Migration
  def up
    create_table :responses do |t|
      t.belongs_to :gossyp
      t.belongs_to :user
      t.text :body
      t.timestamps
    end
  end

  def down
    drop_table :responses
  end
end
