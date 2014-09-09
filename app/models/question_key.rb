require 'rubygems'  
require 'active_record'

class QuestionKey < ActiveRecord::Base
	QuestionKey.establish_connection(YAML.load_file("config/database.yml"))
	
	belongs_to :question
end