class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string :number
      t.string :paid
      t.string :date
      t.string :date_received
      t.string :notax
      t.string :audit
      t.string :timestamp
      t.string :check_number
      t.string :saved

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
