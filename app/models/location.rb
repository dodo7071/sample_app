class Location < ActiveRecord::Base
  attr_accessible :id, :name, :region_id

  has_many :activities
  
  belongs_to :region


end
