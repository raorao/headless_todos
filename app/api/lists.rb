module Lists
  class API < Grape::API
    format :json

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

          put ':item_id' do

            params do
              optional :description, type: String, desc: "Your item's description."
              optional :completed, type: Boolean, desc: "Your item's completeness value."
            end

            item = Item.find params[:item_id]
            new_attributes = {}
            new_attributes[:description] = params[:description] if params[:description]
            new_attributes[:completed]   = params[:completed]   if params[:completed]
            item.update_attributes new_attributes
            item.reload
          end

          delete '/:item_id' do
            Item.find(params[:item_id]).destroy
          end
        end
      end
    end
  end
end