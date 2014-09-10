Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file| require file }

task default: %w[karma]
task create_database: %w[create_db]

def select_user_activity(user)
	begin
		puts "1: Add karmic coins, 2: I'll take the test!, 3: How do I use this?"
		activity = gets.chomp.to_i
		if activity == 1
			UserKarmic.add_karmic_coins(user)
		elsif activity == 2
			
		elsif activity == 3

		else
			puts "Invalid entry! Try again!"
			select_user_activity(user)
		end
	rescue
		puts "Exception found in select_user_activity"
	end
end

def continue_activity?(user)
	begin
		puts "Do you want to continue? 1: Yes, 2: No"
		response = gets.chomp.to_i
		if response == 1
			select_user_activity(user)
		end
	rescue
		puts "Exception found in continue_activity"
	end
end

task :karma do
  	user, existing = User.random_meth
	if not user
		puts "Sorry, User does not exist"
	else
		puts "Welcome #{user.name}"
		if existing == 2
			user.karmic_coins = 20
			user.save
			puts "You get a bonus 20 coins for joining us today! "
		end
			select_user_activity(user)
	end
end

task :create_db do
	ruby "schema.rb"
end