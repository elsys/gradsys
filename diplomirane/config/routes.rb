
Oop::Application.routes.draw do

  get "committees" => 'committees#index'
  get "committees/all"
  get "assemble" => 'assemble#index'
  get "home/index"
  get 'activation' => 'activation#index'
	get 'admin' => 'admin#index'

  controller :activation do
    post 'save_password' => :save_password
    get 'lost_password' => :lost_password
    post 'change_lost_password' => :change_lost_password    
  end  

  controller :committees do
    post 'set_dates' => :set_dates
    post 'set_years' => :set_years
    post 'committee_add_commissioner' => :add_commissioner
    post 'committee_remove_commissioner' => :remove_commissioner
    post 'committee_add_diploma_work' => :add_diploma_work
    post 'committee_remove_diploma_work' => :remove_diploma_work
  end 

  controller :assemble do
    post 'get_student' => :get_student
    post 'remove_student' => :remove_student
    post 'next_round' => :next_round
    post 'new_round' => :new_round 
    post 'remove_round' => :remove_round 
  end

  controller :diploma_works do
    post 'approve_diploma_work' => :approve_diploma_work
    post 'diploma_work_add_student' => :add_student
    post 'diploma_work_remove_student' => :remove_student
    post 'diploma_work_set_year' => :set_year
    post 'diploma_work_covenanted' => :covenanted
    post 'diploma_work_add_student_field' => :add_student_field
    post 'diploma_work_remove_student_field' => :remove_student_field
  end

  controller :students do
    post 'student_set_year' => :set_year
  end  

  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :diploma_works

  resources :teachers

  resources :students

  resources :users

  resources :assemble

  resources :committees

  resources :tags

  resources :committees do
    get :autocomplete_teachers_name, :on => :collection
  end

	get 'students/parse_emails'
	get 'user_mailer' => 'user_mailer#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#
	root :to => 'admin#index'

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
