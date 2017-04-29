require "minitest/autorun"
require_relative"hangman.rb"

class Testhangmanfunctions <Minitest::Test
	def test_class_returns_name
		hangman = Hangman.new("Paul")
		assert_equal(4,hangman.charcount)
	end
	def test_class_user_guess_is_pushed_into_guess_array
		hangman = Hangman.new("Parris")
		letter = "u"
		assert_equal(["u"],hangman.update_guessed(letter))
	end
	def test_user_guess_is_pushed_into_guess_array
		hangman = Hangman.new("Parris")
		hangman.guessed = ["o","y","t"]
		letter = "h"
		assert_equal(["o","y","t","h"],hangman.update_guessed(letter))
	end
	def test_class_if_guess_already_in_array_returns_false
		hangman = Hangman.new("Parris")
		hangman.guessed = ["o","y","t"]	
		letter = "r"
		assert_equal(["o","y","t","r"],hangman.update_guessed(letter))
	end
	def test_class_returns_five_blanks
		hangman = Hangman.new("Paul")
		assert_equal(["_","_","_","_"],hangman.blank)
	end
	def test_class_returns_if_included_in_password
		hangman = Hangman.new("paul")
		letter = "p"
		assert_equal(true,hangman.correct_letter?(letter))	
	end
	def test_returns_correct_index_positions
		hangman = Hangman.new("paul")	
		letter = "P"
		hangman.correct_index(letter)
		assert_equal(["P","_","_","_"],hangman.correct_blank)
	end
	def test_returns_correct_index_position
		hangman = Hangman.new("paul")
		hangman.correct_blank = ["P","_","_","_"]
		letter ="L"
		hangman.correct_index(letter)
		assert_equal(["P","_","_","L"],hangman.correct_blank)
	end
	def test_correct_blank_array_stays_the_same_after_invalid_guess1
		hangman = Hangman.new("hangman")
		letter = "P"
		hangman.correct_index(letter)
		assert_equal(["_","_","_","_","_","_","_"],hangman.correct_blank)
	end
	def test_correct_blank_array_stays_the_same_after_invalid_guess2
		hangman = Hangman.new("HANGMAN")
		letter = "H"	
		hangman.correct_index(letter)
		assert_equal(["H","_","_","_","_","_","_"],hangman.correct_blank)
	end
	def test_class_if_guess_already_in_array_or_not_returns_false
		hangman = Hangman.new("paul")
		hangman.guessed = ["p","c","u"]
		letter = "p"
		assert_equal(false,hangman.available_guess(letter))
	end
	def test_class_see_if_guess_has_been_guessed
		hangman = Hangman.new("paul")
		hangman.guessed = ["s","w","p"]
		letter = "p"
		assert_equal(true,hangman.available_guess(letter))
	end	
end