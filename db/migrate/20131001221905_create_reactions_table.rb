class CreateReactionsTable < ActiveRecord::Migration
  def up
    create_table :reactions do |t|
      t.belongs_to :gossyp
      t.belongs_to :user
      t.text :body
      t.timestamps
    end
  end

  def down
    drop_table :reactions
  end
end
