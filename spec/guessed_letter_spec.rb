require 'spec_helper'

describe(GuessedLetter) do
  it { should belong_to(:word)}
end

describe 'validate_guessedletter' do
  it 'test to make sure no instance is created when empty string is inputed' do
    guessedletter = GuessedLetter.create({:letter => ''})
    expect(GuessedLetter.all).to(eq([]))
  end
end
