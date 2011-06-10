class Post < ActiveRecord::Base
  attr_accessible :title, :blog

  validates :title, :presence => true
end
