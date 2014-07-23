class AddEarlyAdopterToSignups < ActiveRecord::Migration
  def change
  	add_column :signups, :early_adopter, :boolean, default: false
  	add_column :signups, :ip_address, :string
  end
end
