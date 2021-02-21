class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :posts, dependent: :destroy
         has_many :post_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         attachment :profile_image
          # 自分がフォローされる（被フォロー）側の関係性
          has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
          # 自分がフォローする（与フォロー）側の関係性
          has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
          # 被フォロー関係を通じて参照→自分をフォローしている人
          has_many :followers, through: :reverse_of_relationships, source: :follower
          # 与フォロー関係を通じて参照→自分がフォローしている人
          has_many :followings, through: :relationships, source: :followed

          def self.guest
            find_or_create_by!(email: 'guest@example.com') do |user|
              user.password = SecureRandom.urlsafe_base64
              # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
            end
          end


          def follow(user_id)
            relationships.create(followed_id: user_id)
          end

          def unfollow(user_id)
            relationships.find_by(followed_id: user_id).destroy
          end

          def following?(user)
            followings.include?(user)
          end

          def User.search(search,keyword)
              if search == "perfect_match"
                @user = User.where("name LIKE?","#{keyword}")
              elsif search == "partial_match"
                @user = User.where("name LIKE(?)","%#{keyword}%")
              elsif search == "forward_match"
                @user = User.where("name LIKE(?)","#{keyword}%")
              elsif search == "backward_match"
                @user = User.where("name LIKE(?)","%#{keyword}")
              else
                @user = User.all
              end
          end


end