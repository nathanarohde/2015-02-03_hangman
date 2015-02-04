class Word < ActiveRecord::Base
  has_many :guessed_letters
  has_many :word_letters

  validates(:word, {:presence => true})
  before_create(:set_downcase)
  before_create(:set_hangman_counter)
  after_create(:convert_to_letters)

  def hangman_update
    self.hangman_counter += 1
  end

  private

  def set_downcase
    self.word=(word.downcase)
  end

  def convert_to_letters
    letters_of_word = self.word.split(//)
    letters_of_word.each do |letter|
       WordLetter.create({:letter => letter, :word_id => self.id})
     end
  end

  def set_hangman_counter
    self.hangman_counter= 0
  end

end
