class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :number
      t.string :subject
      t.date :created
      t.string :status
      t.string :problem_type

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
