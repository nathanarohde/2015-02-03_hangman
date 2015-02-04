require 'spec_helper'

describe(GuessedLetter) do
  it { should belong_to(:word)}
end

describe 'validate_guessedletter_is_not_blank' do
  it 'test to make sure no instance is created when empty string is inputed' do
    guessedletter = GuessedLetter.create({:letter => ''})
    expect(GuessedLetter.all).to(eq([]))
  end
end

describe 'validate_guessedletter_is_new' do
  it 'test to see if guessed letter is a new entry' do
    guessedletter1 = GuessedLetter.create({:letter => 'a'})
    guessedletter2 = GuessedLetter.create({:letter => 'a'})
    expect(guessedletter2).not_to be_valid
  end
end
