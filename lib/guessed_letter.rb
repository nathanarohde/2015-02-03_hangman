class Guessedletter < ActiveRecord::Base
  belongs_to :word

  validates(:letter, {:presence => true })
end
