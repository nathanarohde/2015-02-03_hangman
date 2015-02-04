class CreateWordsCreateUsedLettersCreateGuessedLetters < ActiveRecord::Migration
  def change
    create_table(:words) do |t|
      t.column(:word, :string)

      t.timestamps
    end

    create_table(:word_letters) do |t|
      t.belongs_to :word
      t.column(:letter, :string)
      t.column(:guessed, :boolean)

      t.timestamps
    end

    create_table(:guessed_letters) do |t|
      t.belongs_to :word
      t.column(:letter, :string)

      t.timestamps
    end

  end
end
