require 'rubygems'  
require 'active_record'
require 'yaml'
require_relative 'user'

class UserKarmic < ActiveRecord::Base

	UserKarmic.establish_connection(YAML.load_file("config/database.yml"))

	def self.continue_activity?(user)
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

	def self.add_karmic_coins(user)

		begin
			puts "Tell us what good deed you did today! Press Enter to submit your answer."
			good_deed = gets.chomp
			UserKarmic.create(:description => good_deed, :user_id => user.id)
			user.karmic_coins.nil? ? user.karmic_coins = 10 : user.karmic_coins += 10
			user.save
			puts "That's great! 10 coins has been added to your Karmic Pocket!"
			puts "Keep up the good work! "
			UserKarmic.continue_activity?(user)
		rescue
			puts "Exception found in add_karmic_coins"
		end

	end

	def self.select_user_activity(user)
		begin
			puts "1: Add karmic coins, 2: I'll take the test!, 3: How do I use this?"
			activity = gets.chomp.to_i
			if activity == 1
				UserKarmic.add_karmic_coins(user)
			elsif activity == 2
				
			else
				puts "Invalid entry! Try again!"
				select_user_activity(user)
			end
		rescue
			puts "Exception found in select_user_activity"
		end
	end
end  

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
		UserKarmic.select_user_activity(user)
end
