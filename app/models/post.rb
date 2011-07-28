class Post < ActiveRecord::Base
  attr_accessible :title, :blog, :draft
  has_many :comments
  has_and_belongs_to_many :groups

  validates :title, :presence => true
  validates :blog, :presence => true

  scope :readable_by, lambda { |user| 
    if user && user.admin?
      #anything goes
    elsif user
      joins('LEFT OUTER JOIN "groups_posts" ON "groups_posts"."post_id" = "posts"."id" LEFT OUTER JOIN "groups" ON "groups"."id" = "groups_posts"."group_id" LEFT OUTER JOIN "users" ON "users"."group_id" = "groups"."id"').
        where(['posts.draft = ? AND (users.id = ? OR users.id IS NULL)', false, user.id]).
        select("DISTINCT 'posts'.*")
    else #public user
      joins('LEFT OUTER JOIN "groups_posts" ON "groups_posts"."post_id" = "posts"."id"').where(:draft => false, :groups_posts => {:group_id => nil})
    end
  }
end
