class Comment < ActiveRecord::Base
  belongs_to :project

  validates :comment, :presence => true
  validates :nickname, :presence => true
end
