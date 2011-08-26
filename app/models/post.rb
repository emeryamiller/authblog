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

  def method_missing(m, *args, &block)
    if [:day, :month, :year].include? m
      [created_at, updated_at].max.send(m)
    else
      super(m, *args, &block)
    end
  end

  def full_post
    "# #{title}\n\n#{blog}"
  end

  def abstract
    words = blog.scan(/\S+/)
    sentances_found = 0
    words.take_while { |word| keep = (sentances_found < 2); sentances_found += 1 if word =~ /\./; keep }
    words[0...30].join(' ')
  end
end
