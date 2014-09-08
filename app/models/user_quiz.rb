require 'rubygems'  
require 'active_record'
require 'yaml'
require 'pry-byebug'

class UserQuiz < ActiveRecord::Base

	UserKarmic.establish_connection(YAML.load_file("config/database.yml"))

	belongs_to :user
	belongs_to :quiz

	def take_test(user)
		
	end

end