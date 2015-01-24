module Lists
  class API < Grape::API
    format :json

    resource :lists do

      helpers do
        def fetch_list
          @list = List.find_by name: params[:name]
          error!({errors: ["Could not find List with name #{params[:name]}"]}, 422) unless @list
        end
      end

      params { requires :name, type: String, desc: "Your list's name." }
      post do
        list = List.create name: params[:name]
        error!({errors: list.errors.full_messages}, 422) unless list.valid?
        list
      end

      segment '/:name' do
        get do
          fetch_list
          @list
        end
        resources :items do
          params do
            requires :description, type: String, desc: "Your item's description."
            requires :completed, type: Boolean, desc: "Your item's completeness value."
          end

          post do
            fetch_list
            @list.items.create({
              description: params[:description],
              completed: params[:completed]
            })
          end

          put ':item_id' do

            params do
              optional :description, type: String, desc: "Your item's description."
              optional :completed, type: Boolean, desc: "Your item's completeness value."
            end

            fetch_list
            item = Item.find params[:item_id]
            new_attributes = {}
            new_attributes[:description] = params[:description] if params[:description]
            new_attributes[:completed]   = params[:completed]   if params[:completed]
            item.update_attributes new_attributes
            item.reload
          end

          delete '/:item_id' do
            fetch_list
            Item.find(params[:item_id]).destroy
          end
        end
      end
    end
  end
end