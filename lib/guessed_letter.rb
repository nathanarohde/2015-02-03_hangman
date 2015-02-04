class GuessedLetter < ActiveRecord::Base
  belongs_to :word

  validates(:letter, {:presence => true })
  validates(:letter, {:uniqueness => true})
end
