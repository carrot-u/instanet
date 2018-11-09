json.extract! team, :id, :name, :description, :is_parent, :active, :parent_team_id, :manager_id, :created_at, :updated_at
json.url team_url(team, format: :json)
