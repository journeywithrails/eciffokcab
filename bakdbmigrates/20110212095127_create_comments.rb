class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :subject
      t.string :body
      t.string :tech

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
