FactoryGirl.define do
  factory :post do
    title 'A new post'
    blog 'some content'
    draft true

    factory :modified_post do
      created_at {500.days.ago}
    end
  end
end
#Factory.define :post do |post|
#  post.title 'A new post'
#  post.blog 'some content'
#  post.draft true
#
#  factory :modified_post do
#    post.created_at { 1.day.ago }
#  end
#end
