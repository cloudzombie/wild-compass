class CreateStrains < ActiveRecord::Migration
  def change
    create_table :strains do |t|
      t.string :name
      t.string :acronym
      t.string :info

      t.timestamps
    end
  end
end
