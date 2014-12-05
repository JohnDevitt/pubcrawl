class Route < ActiveRecord::Base

	has_and_belongs_to_many :pubs
	has_many :rules

end
