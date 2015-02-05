require ('spec_helper')

describe(Word) do
  it { should have_many(:word_letters)}
end

describe(Word) do
  it { should have_many(:guessed_letters)}
end

describe(Word) do
  describe 'set_downcase' do
    it 'tests to see if word is downcase when created' do
      word = Word.create({:word =>'POTATO'})
      expect(word.word).to(eq('potato'))
    end
  end

  describe 'validate_word' do
    it 'test to make sure no instance is create when empty string is inputed' do
      word = Word.create({:word => ''})
      expect(Word.all).to(eq([]))
    end
  end

  describe 'convert_to_letters' do
    it 'tests to see if letters of the word are properly placed in a table' do
      word = Word.create({:word => 'squid'})
      new_word = []
      word.word_letters.each{|wordletter| new_word.push(wordletter.letter)}
      expect(new_word.join('')).to(eq('squid'))
    end
  end

  describe 'set_hangman_counter' do
    it 'tests to see if hangman counter starts at zero' do
      word = Word.create({:word => 'penguin'})
      expect(word.hangman_counter).to(eq(0))
    end
  end

  describe 'hangman_update' do
    it 'updates hangman_counter by 1 everytime it is called' do
      word = Word.create({:word => 'pony'})
      word.hangman_update
      word.hangman_update
      expect(word.hangman_counter).to(eq(2))
    end
  end

  describe 'word_reset' do
    it 'checks to see if hangman counter is reset' do
      word = Word.create({:word => 'reset'})
      word.hangman_update
      word.hangman_update
      word.word_reset
      expect(word.hangman_counter).to(eq(0))
    end

    it 'checks to see if guessed values are destroyed' do
      word = Word.create({:word => 'destroy'})
      guess = GuessedLetter.create({:letter =>'a', :word_id => word.id})
      word.word_reset
      expect(GuessedLetter.all).to(eq([]))
    end

    it 'checks to see if word letters values set false' do
      word = Word.create({:word => 'false'})
      guess = GuessedLetter.create({:letter =>'a', :word_id => word.id})
      word.word_reset
      expect(word.word_letters.any?{|check| check==true}).to(eq(false))
    end

  end

  describe 'delete_word' do
    it 'checks to see if delete word destroys a word and not othe contents of class' do
      word = Word.create({:word => 'delete'})
      guess = GuessedLetter.create({:letter =>'a', :word_id => word.id})
      word2 = Word.create({:word => 'notme'})
      guess2 = GuessedLetter.create({:letter =>'n', :word_id => word2.id})
      word.delete_word
      expect(Word.all.any?{|check_for_word| check_for_word==word}).to(eq(false))
      expect(Word.all.any?{|check_for_word2| check_for_word2==word2}).to(eq(true))
    end

    it 'checks to see if delete word destroys a word and not othe contents of class' do
      word = Word.create({:word => 'abc'})
      word2 = Word.create({:word => 'def'})
      word.delete_word
      expect(WordLetter.all).to(eq(word2.word_letters))
    end

  end




end
