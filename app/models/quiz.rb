require 'rubygems'  
require 'active_record'
require 'yaml'

class Quiz < ActiveRecord::Base
	Quiz.establish_connection(YAML.load_file("config/database.yml"))

	has_many :questions
	has_many :user_quizzes
end