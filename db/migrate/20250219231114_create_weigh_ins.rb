class CreateWeighIns < ActiveRecord::Migration[8.0]
  def change
    create_table :weigh_ins do |t|
      t.integer :weight_g, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :measured_at, null: false

      t.timestamps
    end
  end
end
