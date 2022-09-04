Rails.application.routes.draw do
  root "lists#index"

  devise_for :users

  resources :users

  resources :lists, only: [:index, :new, :create, :show] do
    resources :items, only: [:create]
    resources :multiple_items_scanning, only: [:create]
    resources :results, only: [:index]
    resources :pdf_printer, only: [:index], defaults: { format: 'pdf' }
  end
end
