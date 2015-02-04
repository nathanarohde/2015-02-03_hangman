require('spec_helper')

describe(WordLetter) do
  it{ should belong_to(:word)}
end

describe '#before_create_guessed' do
  it 'checks to see that variable guessed starts as false' do
    wordletter = WordLetter.create({:letter => 's'})
    expect(wordletter.guessed).to(eq(false))
  end
end
