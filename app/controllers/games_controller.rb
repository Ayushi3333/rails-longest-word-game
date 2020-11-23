class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @random = params[:random_letters]
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    parsed_response = JSON.parse(response.read)
    word_arr = @word.split('')
    ans = word_arr.all? { |letter| @random.include?(letter) }
    if !ans
      @result = "Sorry but #{@word} cannot be built out of #{@random}"
    elsif ans && parsed_response["found"] == false
      @result = "Sorry but #{@word} doesn't seem to be a valid English word"
    else
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end
end
