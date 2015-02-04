require('spec_helper')

describe(Wordletter) do
  it{ should belong_to(:word)}
end

describe '#before_create_guessed' do
  it 'checks to see that variable guessed starts as false' do
    wordletter = Wordletter.create({:letter => 's'})
    expect(wordletter.guessed).to(eq(false))
  end
end

# describe(Wordletter) do
#   describe 'delete_quotes' do
#     it 'deletes quotes when inputing a string that has quotes' do
#       wordletter = Wordletter.create({:letter => 's'})
#       expect(Wordletter.all).to(eq([]))
#   end
# end
