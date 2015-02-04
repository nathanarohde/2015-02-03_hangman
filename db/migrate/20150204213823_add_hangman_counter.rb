class AddHangmanCounter < ActiveRecord::Migration
  def change
    add_column(:words, :hangman_counter, :integer)
  end
end
