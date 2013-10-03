class CreateStars < ActiveRecord::Migration
  def up
    create_table :stars do |t|
      t.belongs_to :user
      t.belongs_to :gossyp
      t.timestamps
    end
  end

  def down
    drop_table :stars
  end
end
