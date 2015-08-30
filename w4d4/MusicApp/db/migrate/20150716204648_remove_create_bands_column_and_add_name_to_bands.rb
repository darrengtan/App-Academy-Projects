class RemoveCreateBandsColumnAndAddNameToBands < ActiveRecord::Migration
  def change
    remove_column :bands, :CreateBands
    add_column :bands, :name, :string
    change_column :bands, :name, :string, null: false
  end
end
