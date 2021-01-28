class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :article, null: false, foreigh_key: true
      t.references :user,    null: false, foreigh_key: true
      t.timestamps
    end
  end
end
