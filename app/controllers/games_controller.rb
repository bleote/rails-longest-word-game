require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[1..10]
    @score = nil
  end

  def score
    @input_word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@input_word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    params[:found] = "#{word["found"]}"
    params[:length] = "#{word["length"]}"
    @params_found = params[:found]
    validate
  end

  def validate
    if @params_found == "true"
      @score = "Congratulations! <b>#{@input_word.upcase}</b> is a valid English word!".html_safe
    else
      @score = "Sorry but <b>#{@input_word.upcase}</b> doesn't seem to be a valid English word...".html_safe
    end
  end
end
