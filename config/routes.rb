Rails.application.routes.draw do
  resources :fwords

  resources :ftweets

  resources :target2s

  resources :targets2s

  resources :targets

  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'static_pages#home'

   get 'test' => 'static_pages#test'

   get 'buildfollowers' => 'static_pages#buildfollowers'

   get 'fixnils' => 'static_pages#fixnils'
   get 'favs' => 'static_pages#favs'
   get 'rets' => 'static_pages#rets'
   get 'Data4Eviews' => 'static_pages#d4e'
   get 'gettargets' => 'users#gettargets'
   get 'gettalltargets' => 'users#getalltargets'
   get 'targetsclean' => 'targets#clean'
   get 'spam' => 'targets#spam'
   get 'b4NN' => 'targets#b4NN'
   get 'data' => 'targets#data'

   get 'NNs' => 'nns#base'
   get 'FirstTraining' => 'nns#train1'

   get 'gettarget2s' => 'target2s#get_target2s'
   
   get 'download' => 'static_pages#download'

   get 'get_tweets' => 'ftweets#get_tweets'
   get 'split_words' => 'fwords#split_words'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
