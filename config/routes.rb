Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

# Defines the root path route ("/")
# on the left side of the # is the controller name and on the right side is
the hash name is the action name also use the underscore version of it
    root "blog_post#home"
    get "/AboutMe", to: "about_me#index", as: "about_me"
    get "/BlogPost/new", to: "blog_post#new", as: "new"
    get "/BlogPosts", to: "blog_post#index"
    post "/BlogPosts", to: "blog_post#create", as: "blog_posts"
    get "/BlogPost/:id", to: "blog_post#show", as: "blog_post"
    delete "/BlogPost/:id", to: "blog_post#delete"
    patch "/BlogPost/:id", to: "blog_post#update"
    get "/BlogPost/:id/edit", to: "blog_post#edit", as: "blog_post_edit"
  # line 22 is taking in an argument within the path



  # resources :blog_post, only: [ :index, :show ]
  # Within the routes file I can have different types of verbs that has different actions: is to express intent
  # get(go get me some data), post(I want to create a resource), put/patch(update/change a resource), delete(delete a resource)
end
