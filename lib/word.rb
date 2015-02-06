class Word < ActiveRecord::Base
  has_many :guessed_letters
  has_many :word_letters

  validates :word, {:presence => true}
  validates :word, length: { maximum: 40 }
  validates :word, format: { with: /\A[a-zA-Z\s]+\z/, }
  # /s allows character set to include spaces
  before_create(:set_variables)
  after_create(:convert_to_letters)

  def hangman_update
    self.hangman_counter += 1
    self.is_alive
    self.save
  end

  def word_reset
    self.hangman_counter = 0
    self.alive = true
    self.victory = false
    self.save

    self.word_letters.each() do |correct_letter|
      correct_letter.update({:guessed => false}) unless (correct_letter == ' ')
    end
    self.guessed_letters.each {|guessed_letter| guessed_letter.destroy}
  end

  def delete_word
    self.word_letters.each {|letter| letter.destroy}
    self.guessed_letters.each {|letter| letter.destroy}
    self.destroy
  end

  def is_alive
    self.alive = false if hangman_counter >= 6
  end

  def has_won
    array_of_guesses = []
      self.word_letters.each() do |letter|
        array_of_guesses.push(letter.guessed)
      end
      self.victory = true if array_of_guesses.all? {|guess| guess == true}
      self.save
  end

  def hangman_stage
    stage = case self.hangman_counter
      when 0
         'An empty noose eargly awaits your pretty face.'
      when 1
        'A smiley face dangles from a noose.'
      when 2
        'A smiley face with a torso twists in the wind.'
      when 3
         'A right arm is attached to the torso. The smiley face is no longer smiling.'
      when 4
         'A left arm is attached to the torso.  Your formerly smiling face is beginning to look worried. '
      when 5
         'A right leg is attached to the torso.  Panic breaks across your face. The grim reaper playfully beckons. '
      else
         'Something is screwed up.'
    end
    stage
  end

  private

  def set_variables
    self.word=(word.downcase)
    self.victory = false
    self.alive = true
    self.hangman_counter= 0
  end

  def convert_to_letters
    letters_of_word = self.word.split(//)
    letters_of_word.each do |letter|
       WordLetter.create({:letter => letter, :word_id => self.id})
     end
  end

end
