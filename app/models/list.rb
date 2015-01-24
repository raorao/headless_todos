class List < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :items
  validate :name_must_be_uri_encoded

  def name_must_be_uri_encoded
    unless name == URI.encode(name)
      errors.add(:name, "must be URI encodable")
    end
  end
end