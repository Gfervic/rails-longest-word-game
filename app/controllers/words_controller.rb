require "open-uri"

class WordsController < ApplicationController
  VOWELS = %w(A E I O U)

  def game
    # random new grid of letters
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) {(("A".."Z").to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    # Not able to comput score  as in the ruby exercise - ?. Time problem
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
