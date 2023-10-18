class CreateFootStamps < ActiveRecord::Migration[6.1]
  def change
    create_table :foot_stamps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
