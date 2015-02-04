class WordLetter < ActiveRecord::Base
  belongs_to :word

  before_create(:set_guessed)
  # after_update(:sort_by_order_created)

  def set_guessed
    self.guessed = false
    true
  end

  # def sort_by_order_created
  #   self.sort_by(&:id)
  # end

end
