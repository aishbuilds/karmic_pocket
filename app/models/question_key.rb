require 'rubygems'  
require 'active_record'

class QuestionKey < ActiveRecord::Base
	belongs_to :question
end