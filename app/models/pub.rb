class Pub < ActiveRecord::Base

	has_and_belongs_to_many :routes

	geocoded_by :full_address
	after_validation :geocode

	attr_accessor :streetName

	def full_address
		unless streetName.nil?
			name + " ," + streetName + ",Dublin,Ireland"
		end

		name + " ,Dublin,Ireland"
	end

end
