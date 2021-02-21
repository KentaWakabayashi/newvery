class Post < ApplicationRecord
  belongs_to :user
  attachment :post_image
  has_many :posts
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_images, dependent: :destroy, autosave: true
  accepts_attachments_for :post_images, attachment: :image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :text, presence: true
  validates :post_images, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def Post.search(search,keyword)
    if search == "perfect_match"
      @post = Post.where("text LIKE?","#{keyword}")
    elsif search == "partial_match"
      @post = Post.where("text LIKE(?)","%#{keyword}%")
    elsif search == "forward_match"
      @post = Post.where("text LIKE(?)","#{keyword}%")
    elsif search == "backward_match"
      @post = Post.where("text LIKE(?)","%#{keyword}")
    else
      @post = Post.all
    end
  end

end
