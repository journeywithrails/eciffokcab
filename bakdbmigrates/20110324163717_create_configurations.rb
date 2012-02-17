class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.integer :taxrate
      t.string :business_name
      t.string :admin_user
      t.string :admin_pass
      t.text :invoice_footer

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
