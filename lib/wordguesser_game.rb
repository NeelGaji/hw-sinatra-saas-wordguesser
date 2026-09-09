class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError unless letter.is_a?(String) && letter.match?(/\A[a-zA-Z]\z/)

    letter = letter.downcase
    return false if guesses.include?(letter) || wrong_guesses.include?(letter)

    if word.downcase.include?(letter)
      self.guesses += letter
    else
      self.wrong_guesses += letter
    end
    true
  end

  def word_with_guesses
    word.chars.map { |letter| guesses.include?(letter.downcase) ? letter : '-' }.join
  end

  def check_win_or_lose
    return :win if word.downcase.chars.uniq.all? { |letter| guesses.include?(letter) }
    return :lose if wrong_guesses.length >= 7
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://esaas-randomword-27a759b6224d.herokuapp.com/RandomWord')
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      return http.post(uri, "").body
    end
  end
end
