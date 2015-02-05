require('spec_helper')

describe(WordLetter) do
  it{ should belong_to(:word)}
end

describe '#before_create_guessed' do
  it 'checks to see that variable guessed starts as false' do
    wordletter = WordLetter.create({:letter => 's'})
    expect(wordletter.guessed).to(eq(false))
  end

  it 'checks to see if variable guessed is true for spaces' do
    wordletter = WordLetter.create({:letter => ' '})
    expect(wordletter.guessed).to(eq(true))
  end
end
