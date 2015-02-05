class CreateWordAliveCreateWordVictory < ActiveRecord::Migration
  def change
    add_column(:words, :victory, :boolean)
    add_column(:words, :alive, :boolean)
  end
end
