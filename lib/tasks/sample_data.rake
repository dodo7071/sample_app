namespace :db do
	desc "Fill database with sample data"

	task populate: :environment do
    
		71.times do |n|
			18.times do |m|
				3.times do |o|
		  
					user_id = ((m*n*o)%100)+1
				  	location_id = n+1
					activity_type_id = m+1
					date = "2013-7-" + (((m+o+n)%31)+1).to_s
					beg_time = (o+8).to_s + ":00:00"
					end_time = (o+9+(n%3)).to_s + ":00:00"
					note = "test_note"
					title = "test_activity"

      				Activity.create!(user_id: user_id, location_id: location_id, activity_type_id: activity_type_id, beg_date: date, end_date: date, beg_time: beg_time, end_time: end_time, note: note, title: title)


				end
			end
		end
	end
end
