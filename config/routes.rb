HardReader::Application.routes.draw do
  devise_for :users
  root to: "home#index"
  post "email", to: "emails#post"
end
