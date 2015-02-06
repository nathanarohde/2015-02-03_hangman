class Word < ActiveRecord::Base
  has_many :guessed_letters
  has_many :word_letters

  validates :word, {:presence => true} 
  validates :word, length: { maximum: 40 }
  validates :word, format: { with: /\A[a-zA-Z\s]+\z/, }
  # /s allows character set to include spaces
  before_create(:set_variables)
  after_create(:convert_to_letters)

  def hangman_update
    self.hangman_counter += 1
    self.is_alive
    self.save
  end

  def word_reset
    self.hangman_counter = 0
    self.alive = true
    self.victory = false
    self.save

    self.word_letters.each() do |correct_letter|
      correct_letter.update({:guessed => false}) unless (correct_letter == ' ')
    end
    self.guessed_letters.each {|guessed_letter| guessed_letter.destroy}
  end

  def delete_word
    self.word_letters.each {|letter| letter.destroy}
    self.guessed_letters.each {|letter| letter.destroy}
    self.destroy
  end

  def is_alive
    self.alive = false if hangman_counter >= 6
  end

  def has_won
    array_of_guesses = []
      self.word_letters.each() do |letter|
        array_of_guesses.push(letter.guessed)
      end
      self.victory = true if array_of_guesses.all? {|guess| guess == true}
      self.save
  end

  private

  def set_variables
    self.word=(word.downcase)
    self.victory = false
    self.alive = true
    self.hangman_counter= 0
  end

  def convert_to_letters
    letters_of_word = self.word.split(//)
    letters_of_word.each do |letter|
       WordLetter.create({:letter => letter, :word_id => self.id})
     end
  end

end
