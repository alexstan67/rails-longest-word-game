require "open-uri"

class GamesController < ApplicationController
  def new
    letters = "abcdefghijklmnopqrstuvwxyz"
    @sample_array = letters.upcase!.split(//).sample(10)
    
  end

  def score
    @guess = params[:word]
    @sample_array = params[:sample_array].split(//)
    @guess = @guess.upcase
    guess_array = @guess.split(//)
    if (guess_array - @sample_array).empty?
      @message = isValid(@guess) ? "Well done!" : "Invalid word!"
    else
      @message = "Sorry, but " + @guess + " can't build out " + @sample_array.join
    end
  end

  private

  def isValid(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
