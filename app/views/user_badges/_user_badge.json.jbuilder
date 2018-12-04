json.extract! user_badge, :id, :user_id, :badge, :name, :src, :description, :active, :issued_by_id, :created_at, :updated_at
json.url user_badge_url(user_badge, format: :json)
