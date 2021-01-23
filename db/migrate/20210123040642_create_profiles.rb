class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user,          null: false, foreign_key: true
      t.boolean    :email_publish, null: false, default: false
      t.string     :nickname
      t.string     :site
      t.string     :company
      t.string     :residence
      t.text       :profile
      t.string     :twitter
      t.string     :facebook
      t.date       :birthday, null: false
      t.timestamps
    end
  end
end
