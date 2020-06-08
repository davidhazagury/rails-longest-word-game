require 'open-uri'
class GamesController < ApplicationController
  def new
    # We need to generate a range of letters from A to Z (included). And save 10 of them into an array.
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    # 1. Check if the given word by the user is created with all the letter of the arrays.
    @word = params[:word] # Word given by the user
    @letters = params[:letters].split("") # Letters from the game (initial array)
    input_validation?
    english_word?
    @message = " Invalid input"
    if input_validation? && english_word?
      return @message = " Congrats!"
    end
  end

  def english_word? # API call
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    open_api = open(url).read
    file = JSON.parse(open_api)
    file["found"]
  end

  def input_validation?
    condition = true
    @word.split("").each do |letter|
      if @letters.include?(letter)
        @letters.delete(letter)
      else
        condition = false
      end
    end
    return condition
  end
end
