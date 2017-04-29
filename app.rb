require "sinatra"
require_relative "hangman.rb"
enable :sessions

get '/' do
	erb :index
end

post'/player_names'do
	session[:player1] = params[:player1]
	session[:player2] = params[:player2]
	# "player1 is #{player1} and player2 is #{player2}"
	redirect '/password'
end

get '/password' do
	erb :password, locals: {p1_name: session[:player1], p2_name: session[:player2]} 

 end


post '/secret_password' do
	password = params[:word]
	session[:game]=Hangman.new(password)
	# "player 1 is #{player1} and player 2 is #{player2} and the secret_word is #{password}"
	redirect '/guessing'
end

get '/guessing' do
 	erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank,array: session[:game].guessed,message:"pick a letter",message2: "",counter: session[:game].counter}
end	

 post '/guess' do
 	choice = params[:letter].upcase
 			if session[:game].available_guess(choice)
 			true
 			session[:game].update_guessed(choice)	
 			session[:game].make_move(choice)
 				if session[:game].winner == true
 		 		redirect '/victory_screen'
 		 		else
 		 		if session[:game].failure == true
				redirect'/failure'
 		else
 		erb :guessing, locals:{p1_name: session[:player1], p2_name: session[:player2], blank: session[:game].correct_blank,array: session[:game].guessed,message2:"guess again",message:"",counter: session[:game].counter}
 			end
 		end	
	end	
end	
get '/failure' do 
	erb :failure, locals: {p1_name: session[:player1], p2_name: session[:player2], word: session[:game].name}
end	
get '/victory_screen' do
	erb :victory_screen, locals: {p1_name: session[:player1], p2_name: session[:player2], word: session[:game].name}
end