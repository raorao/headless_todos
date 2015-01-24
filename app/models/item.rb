class Item < ActiveRecord::Base
  belongs_to :list
  def as_json(options = {})
    super except: :list_id, methods: :list_name
  end

  def list_name
    list.name
  end
end