json.array!(@posts) do |post|
  json.extract! post, :id, :user_id, :caption, :created_at
  json.name post.user.name
  json.photo_url full_url(post.photo.url)  if post.photo.present?
  json.photo_thumb_url full_url(post.photo.thumb.url)  if post.photo.present?
end
