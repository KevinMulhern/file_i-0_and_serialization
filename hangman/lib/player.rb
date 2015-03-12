class Player
	attr_accessor :name 
	def initialize
		@name = get_name

	end

	def get_name
		print "Please Enter your name: "
		name = gets.chomp.capitalize
	end

	def enter_guess
			print "Please enter a letter or enter 'save': "
			input = gets.chomp.downcase
	end

	def continue_or_save
		loop do 
			print "Enter 'c' to countinue or  's' to save the game and quit: "
			option = gets.chomp.downcase

			if option == "s"  || option == "c"
				return option
				break
			else
				puts "Invalid option, please enter 's or 'c': "
			end
		end
	end

	def enter_option
		loop do 
			print "  Please enter a option: "
			input = gets.chomp.to_i

			if input < 1 || input > 2
				puts "Invalid option, please choose a option between 1 and 2: ".center(70)
			else
				return input
				break
			end
		end
	end
end