class CreateUpgrades < ActiveRecord::Migration
  def self.up
    create_table :upgrades do |t|
      t.string :pc_desc
      t.date :pc_age
      t.string :operating_system
      t.integer :memory
      t.integer :disk_size
      t.integer :disk_used_percent
      t.string :av_software
      t.string :backups
      t.references :customer

      t.timestamps
    end
  end

  def self.down
    drop_table :upgrades
  end
end
