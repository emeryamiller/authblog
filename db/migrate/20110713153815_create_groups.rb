class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    change_table :users do |u|
      u.references :group
    end
  end

  def self.down
    drop_table :groups

    remove_column :users, :group
  end
end
