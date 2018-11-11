json.extract! user, :id, :first_name, :last_name, :title, :tier, :team_id, :email, :slack, :bio, :is_manager, :active, :created_at, :updated_at, :manager_id, :started_at
json.url user_url(user, format: :json)
