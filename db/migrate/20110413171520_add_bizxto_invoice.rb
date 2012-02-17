class AddBizxtoInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :bizx, :boolean
  end

  def self.down
    remove_column :invoices, :bizx, :boolean

  end
end
