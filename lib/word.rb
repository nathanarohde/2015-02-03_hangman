class Word < ActiveRecord::Base
  has_many :guessed_letters
  has_many :word_letters

  validates(:word, {:presence => true})
  validates :word, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  before_create(:set_downcase)
  before_create(:set_hangman_counter)
  after_create(:convert_to_letters)

  def hangman_update
    self.hangman_counter += 1
    self.save
  end

  def word_reset
    self.hangman_counter = 0
    self.save

    self.word_letters.each {|correct_letter| correct_letter.update({:guessed => false})}
    self.guessed_letters.each {|guessed_letter| guessed_letter.destroy}
  end

  def delete_word
    self.word_letters.each {|letter| letter.destroy}
    self.guessed_letters.each {|letter| letter.destroy}
    self.destroy
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
