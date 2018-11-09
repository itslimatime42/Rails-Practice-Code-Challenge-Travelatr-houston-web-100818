class Blogger < ApplicationRecord
  has_many :posts
  has_many :destinations, through: :posts

  validates :name, uniqueness: true
  validates :age, numericality: { greater_than: 0 }
  validates :bio, length: { minimum: 30 }

  def total_likes
    likes = 0
    self.posts.each { |post| likes += post.likes }
    likes
  end

  def featured_post
      self.posts.order(likes: :desc).limit(1)[0]
  end

  def favorite_destinations
    dest_hash = self.posts.group("destination_id").order("count_destination_id desc").count("destination_id").first(5).to_h # { destination_id => count }

    dest_array = []
    dest_hash.each { |k, v| dest_array << Destination.find(k) }
    dest_array
  end

end
