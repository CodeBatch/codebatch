Rails.application.routes.draw do
  
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  
    root "home#index"

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
    }

    get '/contact', to: "contact#index"
    get '/code_of_conduct', to: "code_of_conduct#index"
    get '/terms_of_use', to: "terms_of_use#index"
    get '/privacy_police', to: "privacy_police#index"

    get '/dashboard', to: "dashboard#index"
    get '/dashboard/articles', to: "dashboard#articles"
    get '/dashboard/follows', to: "dashboard#follows"
    get '/dashboard/profile', to: "dashboard#profile"
    get '/dashboard/settings', to: "dashboard#settings"
    get '/dashboard/stats', to: "dashboard#stats"
    get '/dashboard/data', to: "dashboard#data"
    get '/dashboard/videos', to: "dashboard#videos"
    get '/dashboard/podcasts', to: "dashboard#podcasts"
    get '/dashboard/jobs', to: "dashboard#jobs"
    get '/dashboard/discuss', to: "dashboard#discuss"
    get '/dashboard/saved_articles', to: "dashboard#saved_articles"
    get '/dashboard/liked_articles', to: "dashboard#liked_articles"

    resources :articles do resources :comments end
    resources :videos do resources :video_comments end

    put '/articles/:id/like', to: "articles#like", as: 'like'
    delete '/articles/:id/unlike', to: "articles#unlike", as: 'unlike'

    put '/articles/:id/store', to: "articles#store", as: 'store'
    delete '/articles/:id/unstore', to: "articles#unstore", as: 'unstore'

    put '/videos/:id/video_like', to: "videos#video_like", as: 'video_like'
    delete '/videos/:id/video_unlike', to: "videos#video_unlike", as: 'video_unlike'

  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end