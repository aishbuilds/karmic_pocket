require 'rubygems'  
require 'active_record'

class Question < ActiveRecord::Base
	Question.establish_connection(YAML.load_file("config/database.yml"))
	
	belongs_to :quiz
	has_many :answers
	has_one :question_key
end