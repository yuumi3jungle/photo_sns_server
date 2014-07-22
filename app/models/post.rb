class Post < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user

  MINIMUM_POST_INTERVAL_SEC = 3

  
  validate :post_interval_time

  def post_interval_time
    last_post = Post.where(user_id: self.user_id).last
    if last_post && Time.now - last_post.created_at <= MINIMUM_POST_INTERVAL_SEC
      errors.add(:base, "#{MINIMUM_POST_INTERVAL_SEC}秒以内の連続投稿は出来ません")
    end
  end
end
