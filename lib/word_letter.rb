class Wordletter < ActiveRecord::Base
  belongs_to :word

  # before_create(:delete_quotes)
  #
  # private
  #
  # def delete_quotes
  #   self.delete(" ' ")
  # end

end
