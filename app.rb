require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname(__FILE__)+'/lib/*.rb'].each {|file| require file}

get '/' do
  @words = Word.all

  erb :index
end

post '/add_word' do
  new_word = params['word']
  @word = Word.create({:word => new_word})

  redirect '/'
end

get '/word/:id' do
  @word = Word.find(params['id'])
  @letter_range = ('a'..'z')

  erb :word
end

delete "/delete_word" do
  @word = Word.find(params['id'])
  @word.word_letters.each {|letter| letter.destroy}
  @word.destroy
  redirect'/'
end

post '/guessed_letter' do
  @word = Word.find(params['id'])
  @submitted_guessed_letter = params['guessed_letter']
  @guessed_letter = GuessedLetter.create({:letter => @submitted_guessed_letter, :word_id => @word.id})


  wrong_guess = 0
  @word.word_letters.each do |wordletter|
    if wordletter.letter == @guessed_letter
      wordletter.update({:guessed => true})
    else
      wrong_guess += 1
    end

    @word.hangman_update if wrong_guess == @word.word.length

  end

  redirect back
end

patch '/reset_word' do
  @word = Word.find(params['id'])
  @word.hangman_counter.update({:hangman_counter => 0})
  @word.word_letters.each {|wordletter| wordletter.update({:guessed => false})}

  redirect back
end
