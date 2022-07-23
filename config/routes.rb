Rails.application.routes.draw do
  root "static#index"

  get "login" => "sessions#new" 
  get "auth/github/callback" => "sessions#create"
  get "pull_requests" => "pull_requests#index"
  post "pull_requests" => "pull_requests#create"
  post "pull_requests/bump" => "pull_requests#bump"

  post "teams" => "teams#create"
  post "teams/set" => "teams#set_team"
  get "teams" => "teams#index"
  delete "teams/:id" => "teams#destroy"
  put "teams/:id" => "teams#update"

  post "hooks/github" => "hooks#github"
  get "hooks/github" => "hooks#github"
  post "opened_pull_request" => "public_repositories#opened_pr_notification"
  post "closed_pull_request" => "public_repositories#closed_pr_notification"

  post "api/pull_requests" => "api#create_pull_request_blurb"

  get "extension/teams" => "extensions#teams"
  post "extension/create" => "extensions#create"

end
