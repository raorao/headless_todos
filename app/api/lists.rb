module Lists
  class API < Grape::API
    resource :lists do
      params do
        requires :name, type: String, desc: "Your list's name."
      end
      post do
        list = List.create name: params[:name]
        if list.valid?
          status 201
        else
          status 422
        end
      end
    end
  end
end