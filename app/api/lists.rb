module Lists
  class API < Grape::API
    resource :lists do

      params { requires :name, type: String, desc: "Your list's name." }
      post do
        list = List.create name: params[:name]
        if list.valid?
          status 201
        else
          status 422
        end
      end

      segment '/:name' do
        resources :items do
          params do
            requires :description, type: String, desc: "Your item's description."
            requires :completed, type: Boolean, desc: "Your item's completeness value."
          end

          post do
            list = List.find_by name: params[:name]
            list.items.create({
              description: params[:description],
              completed: params[:completed]
            })
          end
        end
      end
    end
  end
end