class CreateLinetypes < ActiveRecord::Migration
  def self.up
    create_table :linetypes do |t|
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :linetypes
  end
end
