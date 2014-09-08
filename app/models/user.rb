require 'rubygems'  
require 'active_record'
require 'pry-byebug'

class User < ActiveRecord::Base

	User.establish_connection(YAML.load_file("config/database.yml"))

	has_many :user_karmics
	has_many :user_quizzes
	
	def self.create_user
		begin
			puts "Enter your name"
			name = gets.chomp
			puts "Enter your email"
			email = gets.chomp
			puts "Enter your password"
			password = gets.chomp
			user = User.create(:name => name, :email => email, :password => password)
			return user
		rescue
			puts "Exception found in create user"
		end
	end

	def self.check_valid_user?
		begin
			puts "Enter your email"
			email = gets.chomp
			puts "Enter your password"
			password = gets.chomp
			user = User.where(email: email, password: password)
			return user
		rescue
			puts "Exception found in check_valid_user"
		end
	end

	def self.random_meth	
		
		begin
			puts "Are you an existing user? 1: Yes, 2: No"
			existing = gets.chomp.to_i
			if existing == 1
				user = User.check_valid_user?
				if ((not user.empty?) and (not user.first.nil?))
					return user.first, existing
				else
					return false, existing
				end
			elsif existing == 2
				user = User.create_user
				return user, existing
			else
				puts "Invalid entry"	
			end
		rescue
			puts "Exception found in random_meth"
		end

	end
end