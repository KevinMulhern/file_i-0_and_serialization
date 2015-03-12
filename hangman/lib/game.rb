require 'yaml'

class Game
	load "player.rb"
	def initialize
		puts Dir.pwd
		@player = Player.new
		@turn_count = 0
		@secret_answer = generate_word
		@blank_word = blank_the_word(@secret_answer)
	end

	def menu
		system 'clear'
		puts "HANG MAN".center(30)
		puts
		puts "  Hi #{@player.name} welcome to hang man."
		puts "  Please select one of the following options: "
		puts 
		puts "  1. New Game"
		puts "  2. Load Game"
		puts
		option = @player.enter_option
		navigation(option) 
	end


	def navigation(option)
		case option
		when 1
			new_game
		when 2
			load_game
		end
	end


protected
	def save_game
		save_game = YAML::dump(self)
		save = File.new("../saves.yaml", "w")
		save.write(save_game)
		save.close
		print "saving the file "
		3.times do 
			sleep(1)
			print "."
		end
		puts "\n"
	end

	def new_game
		loop do
			system 'clear'
			draw_board
			puts "chances left: #{6 - @turn_count}"
			guess = guess_valid
			

			 if @secret_answer.include?(guess)
			 	correct?(guess)
			 else
			 	@turn_count += 1
			 end

			if win?
				outcome = "won"
				result_screen(outcome)
				break
			elsif @turn_count >= 6
				outcome = "lost"
			
				result_screen(outcome)
				break
			end
		end

	end


	def correct?(letter)
		@secret_answer.each_with_index do |l, i|
			if l == letter
		  		@blank_word[i] = letter
			end
		end
	end


	def load_game
		load_game = File.open("../saves.yaml", "r")
		game = load_game.read
		YAML::load(game).new_game
	end

	def generate_word
		words = File.read('../5desk.txt')
		suitable_words = []

		words.split().each do |word|
			if word.size > 5 && word.length < 12
				suitable_words << word
			end
		end
		answer = suitable_words.sample.downcase.split("").to_a
		return answer
	end

	def win?
		if @blank_word == @secret_answer
			return true
		end
	end

	def result_screen(outcome)
		system 'clear'
		draw_board
		puts "You have #{outcome}!"
		puts "The word was: #{@secret_answer.join()}"
		play_again?
	end

	def play_again?
		loop do
			print "Do you want to play again? (y/n): "
			input = gets.chomp.downcase

			if input == "y"
				@secret_answer = generate_word
				@blank_word = blank_the_word(@secret_answer)
				@turn_count = 0 
				menu
				break
			elsif input == "n"
				exit
				break
			else
				puts "Invalid option, please enter either 'y' or 'n'"
			end
		end
	end

	def blank_the_word(answer)
		blank_word = Array.new(answer.size)
		i = 0
		while i < blank_word.size
			blank_word[i] = " _ "
			i += 1
		end
		blank_word
	end

	def draw_board
		board(@turn_count)
		puts "\n"
		puts "Word: #{@blank_word.join()}".center(70)
		puts "\n"
	end

	def guess_valid
		valid = false
		while valid == false 
			guess = @player.enter_guess

			if @blank_word.include?(guess)
				puts "That letter has already been guessed, please guess again"
			elsif guess == 'save'
				save_game
			elsif ("a".."z").to_a.include?(guess) && guess.size == 1
				return guess
				valid = true
			else
				puts "Invalid input, please enter a letter"
			end
		end
	end
				

	def board(count)
		case count
		when 0
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "              |".center(70)
			puts	 "             |".center(70)
			puts	 "             |".center(70)
			puts	 "              |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 1
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "   O         |".center(70)
			puts	 "             |".center(70)
			puts	 "             |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 2
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "   O         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 3
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 4
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O/        |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "             |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 5
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O/        |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   /          |".center(70)
			puts     "             |".center(70)
			puts "\n"
		when 6
			puts "\n"
			puts       " -----------".center(70)
			puts     "   |         |".center(70)
			puts	 "  \\O/        |".center(70)
			puts	 "   |         |".center(70)
			puts	 "   |         |".center(70)
			puts	 "  / \\        |".center(70)
			puts     "             |".center(70)
			puts "\n"
		end
	end
end

hangman = Game.new
hangman.menu