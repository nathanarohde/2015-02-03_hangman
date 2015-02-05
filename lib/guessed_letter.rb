class GuessedLetter < ActiveRecord::Base
  belongs_to :word

  validates(:letter, {:presence => true })
  validates(:letter, {:uniqueness => true})

  after_create(:check_guess)

  def check_guess

    word.word_letters.each { |correct_letter| correct_letter.update({:guessed => true}) if (correct_letter.letter == self.letter)}

    word.hangman_update unless !word.word_letters.any? {self.letter}
  end

end
