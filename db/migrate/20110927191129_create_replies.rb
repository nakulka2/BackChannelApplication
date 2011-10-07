class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :response
      t.references :user
      t.references :post
      t.integer :vcount

      t.timestamps
    end
  end
end
