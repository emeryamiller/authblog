class Post < ActiveRecord::Base
  attr_accessible :title, :blog, :draft
  has_many :comments

  validates :title, :presence => true
  validates :blog, :presence => true
end
