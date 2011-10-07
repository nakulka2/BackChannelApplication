class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :voter
      t.string :vtype
      t.integer :pr_id

      t.timestamps
    end
  end
end
