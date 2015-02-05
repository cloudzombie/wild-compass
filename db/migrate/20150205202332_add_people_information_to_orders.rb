class AddPeopleInformationToOrders < ActiveRecord::Migration
  def change
    add_column    :orders, :created_by, :string, null: false, default: ''
    add_column    :orders, :placed_by,  :string, null: false, default: ''
    change_column :orders, :customer,   :string, null: false, default: ''
  end
end
