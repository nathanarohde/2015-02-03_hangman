class Word < ActiveRecord::Base
  has_many :guessedletters
  has_many :wordletters

  validates(:word, {:presence => true})
  before_create(:set_downcase)

  private

  def set_downcase
    self.word=(word.downcase)
  end

end
