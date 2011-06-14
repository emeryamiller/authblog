class Post < ActiveRecord::Base
  attr_accessible :title, :blog, :draft

  validates :title, :presence => true
  validates :blog, :presence => true
end
