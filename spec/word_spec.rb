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


end
