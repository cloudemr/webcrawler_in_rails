class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :email_id
      t.string :password
      t.string :preferences

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
