require 'spec_helper'

describe(Guessedletter) do
  it { should belong_to(:word)}
end

describe 'validate_guessedletter' do
  it 'test to make sure no instance is created when empty string is inputed' do
    guessedletter = Guessedletter.create({:letter => ''})
    expect(Guessedletter.all).to(eq([]))
  end
end
