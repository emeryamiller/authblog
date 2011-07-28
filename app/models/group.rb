class Group < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :posts
  validates :name, :presence => true 
end