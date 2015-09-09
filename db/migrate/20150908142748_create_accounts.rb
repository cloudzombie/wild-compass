class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :number, null: false
      t.decimal :value,  null: false, default: 0.0

      t.timestamps null: false
    end

    add_index :accounts, :number, unique: true
  end
end
