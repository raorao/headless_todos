module Lists
  class API < Grape::API
    resource :lists do
      params do
        requires :name, type: String, desc: "Your list's name."
      end
      post do
        List.create name: params[:name]
      end
    end
  end
end