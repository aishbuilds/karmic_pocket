require 'rubygems'  
require 'active_record'

class User < ActiveRecord::Base

	def self.create_user
		
		ActiveRecord::Base.establish_connection(  
			:adapter => "mysql",  
			:host => "localhost",
			:username => 'root',
			:password => 'root123',
			:database => "karmic"  
		)

		puts "Enter your name"
		name = gets.chomp
		puts "Enter your email"
		email = gets.chomp
		puts "Enter your password"
		password = gets.chomp
		user = User.create(:name => name, :email => email, :password => password)
		return user
	end

	def self.check_valid_user?

		ActiveRecord::Base.establish_connection(  
			:adapter => "mysql",  
			:host => "localhost",
			:username => 'root',
			:password => 'root123',
			:database => "karmic"  
		)

		puts "Enter your email"
		email = gets.chomp
		puts "Enter your password"
		password = gets.chomp
		user = User.where(email: email, password: password)
		return user
	end

	def self.random_meth	
		
		ActiveRecord::Base.establish_connection(  
			:adapter => "mysql",  
			:host => "localhost",
			:username => 'root',
			:password => 'root123',
			:database => "karmic"  
		)

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
			puts "Exception found"
		end

	end
end