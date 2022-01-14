require 'open-uri'
require 'JSON'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = JSON.parse(open(url).read)
    json['found']
  end

end
