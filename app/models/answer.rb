require 'rubygems'  
require 'active_record'

class Answer < ActiveRecord::Base
	Answer.establish_connection(YAML.load_file("config/database.yml"))

	belongs_to :question
end

