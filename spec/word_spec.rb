require ('spec_helper')

describe(Word) do
  it { should have_many(:wordletters)}
end

describe(Word) do
  it { should have_many(:guessedletters)}
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
  
end
