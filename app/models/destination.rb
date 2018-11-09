class Destination < ApplicationRecord
  has_many :posts
  has_many :bloggers, through: :posts

  validates :name, uniqueness: true

  def last_5_posts
    self.posts.order(created_at: :desc).limit(5)
  end

  def featured_post
      self.posts.order(likes: :desc).limit(1)[0]
  end

  def avg_blogger_age
    years = self.bloggers.uniq.inject(0) do |sum, blogger|
      sum + blogger.age
    end
    years / self.bloggers.uniq.count
  end

end
