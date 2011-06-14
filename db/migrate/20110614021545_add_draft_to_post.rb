class AddDraftToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :draft, :boolean, :default => true
  end

  def self.down
    remove_column :posts, :draft
  end
end
