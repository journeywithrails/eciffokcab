class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :id
      t.string :requestedon
      t.string :ticketnum
      t.string :parturl
      t.string :shipping
      t.string :deststore
      t.string :orderedby
      t.string :orderedon
      t.string :trackingnum
      t.string :receivedon

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
