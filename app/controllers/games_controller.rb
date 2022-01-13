class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @answer = params[:answer]
    @result = wordcheck(@answer)
  end

  def wordcheck(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = open(url).read
    objs = JSON.parse(json)
    if word.present?
      if objs["found"] == true && lettercheck(word) == true
        "Congratulation, #{word} is a valid word."
      else
        "#{word} is an invalid word."
      end
    else
      "Type your word!"
    end
  end

  def lettercheck(word)
    word.each do |letter|
      if letter.include?(@letters)
        return true
      else
        return false
      end
    end
  end

end
