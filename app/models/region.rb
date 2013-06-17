class Region < ActiveRecord::Base
  attr_accessible :country_id, :name

  has_many :locations  

end
