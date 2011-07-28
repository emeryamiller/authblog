class Grouppost < ActiveRecord::Migration
  def self.up
    create_table :groups_posts, id:false do |t|
      t.references :group
      t.references :post
    end
  end

  def self.down
    drop_table :groups_posts
  end
end
