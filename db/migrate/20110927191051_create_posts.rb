class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_owner
      t.string :question
      t.references :user
      t.integer :vcount

      t.timestamps
    end
  end
end
