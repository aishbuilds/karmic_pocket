require 'rubygems'  
require 'active_record'

ActiveRecord::Base.establish_connection((YAML.load_file("config/database.yml")))

begin
	ActiveRecord::Schema.define do

		create_table :users do |t|
			t.string :name, :null => false
			t.string :email, :null => false, :unique => true
			t.string :password, :null => false
			t.integer :karmic_coins, :default => 0
			t.timestamps
		end

		create_table :user_karmics do |t|
			t.string :description, :null => false
			t.integer :user_id
			t.timestamps
		end

		create_table :categories do |t|
			t.string :title
			t.timestamps
		end 

		create_table :questions do |t|
			t.string :description
			t.integer :category_id
			t.timestamps
		end

		create_table :answers do |t|
			t.string :description
			t.integer :question_id
			t.integer :option_no
			t.timestamps
		end

		create_table :question_keys do |t|
			t.integer :question_id
			t.integer :answer_key
		end
	end
rescue ActiveRecord::StatementInvalid
	# Do nothing - schema already exists
end

class Category < ActiveRecord::Base
	has_many :questions
end

class Question < ActiveRecord::Base
	belongs_to :category
	has_many :answers
	has_one :question_key
end

class Answers < ActiveRecord::Base
	belongs_to :question
end

class QuestionKey < ActiveRecord::Base
	belongs_to :question
end

categories = ["Application", "Analysis", "Synthesis", "Evaluation"]

categories.each do |category|
	Category.create(title: category)
end

question_answers = [
	{
		question: "If I meet someone new and I want to show good manners, I should: ",
		answers: ["smile and say 'hello'.", "pretend I don't see him.", "stare.", "say nothing."],
		answer_key: 1,
		category_id: 1
	},
	{
		question: "If I bump into someone, I should: ",
		answers: ["say nothing.", "do nothing.", "say 'I'm sorry.'", "glare at him."],
		answer_key: 3,
		category_id: 1
	},
	{
		question: "If I'm sitting on a crowded bus or train and someone older than I am gets on, I should: ",
		answers: ["do nothing.", "get up and give that person my seat.", "stare at him.", "make fun of him."],
		answer_key: 2,
		category_id: 1
	},
	{
		question: "If someone is talking on the telephone, and I interrupt, that is: ",
		answers: ["perfectly all right.", "good manners.", "not good manners.", "none of the above."],
		answer_key: 3,
		category_id: 1
	},
	{
		question: "When we don't talk with our mouths full of food, that is: ",
		answers: ["strange", "painful",  "silly", "good manners."],
		answer_key: 4,
		category_id: 1
	},
	{
		question: "If someone is in his room with the door closed, I should: ",
		answers: ["go right in.", "go away. ", "go around and look in the window.", "knock on the door."],
		answer_key: 4,
		category_id: 1
	},
	{
		question: "If I want to get to the head of the line so I'm not late, but I want to use good manners I could: ",
		answers: ["barge in front of the first person. ", "wait my turn, but loudly complain that I’m going to be late. ",
					"get mad and stomp away.", 
					"say to the first person 'Excuse me, could I please go first? I'm afraid I'm going to be late.'"],
		answer_key: 4,
		category_id: 2
	},
	{
		question: "If I'm running, and I bump into someone, good manners would be to:",
		answers: ["say 'It was all your fault.'", "say 'I'm sorry.' ", "say nothing.", "do nothing."],
		answer_key: 2,
		category_id: 2
	},
	{
		question: "If I'm eating with people, and I burp, it would be good manners to: ",
		answers: ["leave and never come back.", "laugh and make fun of myself.' ", "say 'excuse me.'", "do nothing."],
		answer_key: 3,
		category_id: 2
	},
	{
		question: "My friend has been playing at my house all day. It's time for him to go home. I should say: ",
		answers: ["I'm glad you're leaving.", "I'm glad you don't live around here.", 
					"I'm glad this day is finally over", "I'm glad you came."],
		answer_key: 4,
		category_id: 2
	},
	{
		question: "Leaving the library, I let go of the door right in some people's faces. Instead, I should have: ",
		answers: ["held the door for them", "slowed down a little.", "been more careful.", "all of the above."],
		answer_key: 4,
		category_id: 2
	},
	{
		question: "You accidentally knock over a neighbor's vase. You should say: ",
		answers: ["I'm sorry.", "nothing", "It wasn't my fault.", "The cat did it."],
		answer_key: 1,
		category_id: 2
	},
	{
		question: "Someone has just given you a birthday present that you don't really like. You should say: ",
		answers: ["I didn't want this!", "I'm sorry!", "Thank you!", "None of the above"],
		answer_key: 3,
		category_id: 3
	},
	{
		question: "You notice a friend looking very sad and tired. You realize this would be a good time to: ",
		answers: ["ignore your friend.", "hit your friend.", "Ask him if he would want to talk?", "None of the above"],
		answer_key: 3,
		category_id: 3
	},
	{
		question: "An example of good manners is: ",
		answers: ["someone making fun of someone.", "someone laughing at someone.", 
					"someone kicking someone.", "someone treating someone kindly."],
		answer_key: 4,
		category_id: 3
	},
	{
		question: "You and your friends are having fun walking through the mall. Good manners means: ",
		answers: ["running into people.", "walking on the right-hand side.", 
					"being loud and boisterous.", "stealing things."],
		answer_key: 2,
		category_id: 3
	},
	{
		question: "Your mother is on the telephone, but you want to ask for $1.00. Good manners means: ",
		answers: ["you keep bugging her until she gives you the money. ", 
					"you keep calling her name until she looks at you.",
					"you keep jumping up and down in front of her.", 
					"you wait until she hangs up before you ask for the money."],
		answer_key: 4,
		category_id: 3
	},
	{
		question: "Someone has just given you a compliment. It’s good manners to say: ",
		answers: ["Thank you!", "something quiet, so that no one can hear you", 
					"You must be kidding!", "nothing."],
		answer_key: 1,
		category_id: 3
	},
	{
		question: "Someone who says 'excuse me' when she burps is: ",
		answers: ["talking too much. ", "being too noisy.", "being polite.", "being annoying."],
		answer_key: 3
	},
	{
		question: "Using good manners is: ",
		answers: ["a good idea.", "a bad idea.", "a silly idea. ", "not important."],
		answer_key: 1,
		category_id: 4
	},
	{
		question: "Using good manners makes: ",
		answers: ["everyone uneasy. ", "getting along easier.", "getting along harder.", "everyone sad."],
		answer_key: 2,
		category_id: 4
	},
	{
		question: "The person using good manners is the one who: ",
		answers: ["shoves people out of the way.", "talks with food in his mouth. ", 
					"stares at the floor and says nothing when meeting someone new.", 
					"says 'thank you for coming' when you leave."],
		answer_key: 4,
		category_id: 4
	},
	{
		question: "The person not using good manners is the one who: ",
		answers: ["says 'I'm sorry' when someone gets hurts.", "waits his turn in line. ", 
					"smiles and gives her name when meeting someone.", "Laughs at someone when he falls down."],
		answer_key: 4,
		category_id: 4
	},
	{
		question: "Treating people kindly is important: ",
		answers: ["only when we want them to like us.", "only when someone is looking.", 
					"all the time", "only when we want to get our own way."],
		answer_key: 3,
		category_id: 4
	}
]
				
question_answers.each do |item|
	question = Question.create(description: item[:question], category_id: item[:category_id])
	ans = nil
	item[:answers].each_with_index do |answer, index|
		Answers.create(description: answer, question_id: question.id, option_no: index + 1)
	end
	QuestionKey.create(question_id: question.id, answer_key: item[:answer_key])
end

