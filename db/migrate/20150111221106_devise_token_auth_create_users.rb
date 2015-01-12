class DeviseTokenAuthCreateUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, null: false, default: ''
      t.string :uid, null: false, default: ''

      ## Database authenticatable
      # t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      # t.string   :reset_password_token
      # t.datetime :reset_password_sent_at

      ## Rememberable
      # t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Tokens
      t.text :tokens
    end

    # add_index :users, [:uid, :provider],     :unique => true
  end
end