class AddlatlongToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :latitude, :float
    add_column :customers, :longitude, :float

  end

  def self.down
    remove_column :customers, :latitude, :float
    remove_column :customers, :longitude, :float
  end
end
