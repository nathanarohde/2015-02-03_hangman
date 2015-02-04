ENV['RACK_ENV'] = 'test'

require('bundler/setup')
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file}

RSpec.configure do |config|
  config.after(:each) do
    Word.all.each do |word|
      word.destroy
    end
    WordLetter.all.each do |word_letter|
      word_letter.destroy
    end
    GuessedLetter.all.each do |guessed_letter|
      guessed_letter.destroy
    end
  end
end
