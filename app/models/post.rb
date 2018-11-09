class Post < ApplicationRecord
  belongs_to :blogger
  belongs_to :destination

  validates :title, presence: true
  validates :content, length: { minimum: 100 }

  def add_like
    self.likes += 1
    self.save
  end

end
