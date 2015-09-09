class CreateAccountPrefixes < ActiveRecord::Migration
  def change
    create_table :account_prefixes do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :account_prefixes, :name, unique: true
  end
end
