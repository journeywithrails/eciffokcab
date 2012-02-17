class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :mobile

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
