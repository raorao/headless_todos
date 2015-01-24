class List < ActiveRecord::Base
  validates :name, uniqueness: true
end