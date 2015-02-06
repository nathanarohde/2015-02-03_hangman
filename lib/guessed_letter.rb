class GuessedLetter < ActiveRecord::Base
  belongs_to :word

  validates(:letter, {:presence => true })
  validates(:letter, uniqueness: {scope: :word_id})

  after_create(:check_guess)

  def check_guess

    word.word_letters.each { |correct_letter| correct_letter.update({:guessed => true}) if (correct_letter.letter == self.letter)}

    if word.word.split(//).any?{|check| check == self.letter }
      word.has_won
    else
      word.hangman_update
    end

  end

end
