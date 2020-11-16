class AddCookedToCookies < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :cooked, :boolean, default: false
  end
end
