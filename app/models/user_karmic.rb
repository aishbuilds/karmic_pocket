require 'rubygems'  
require 'active_record'
require 'yaml'
require 'pry-byebug'

class UserKarmic < ActiveRecord::Base

	UserKarmic.establish_connection(YAML.load_file("config/database.yml"))

	belongs_to :user

	def self.add_karmic_coins(user)

		begin
			puts "Tell us what good deed you did today! Press Enter to submit your answer."
			good_deed = gets.chomp
			UserKarmic.create(:description => good_deed, :user_id => user.id)
			user.karmic_coins.nil? ? user.karmic_coins = 10 : user.karmic_coins += 10
			user.save
			puts "That's great! 10 coins has been added to your Karmic Pocket!"
			puts "Keep up the good work! "
			continue_activity?(user)
		rescue
			puts "Exception found in add_karmic_coins"
		end

	end
end
