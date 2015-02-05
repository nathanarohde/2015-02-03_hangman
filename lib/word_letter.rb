class WordLetter < ActiveRecord::Base
  belongs_to :word

  before_create(:set_guessed)

  def set_guessed
    self.guessed = false
    self.guessed = true if self.letter == ' '
  end

end
