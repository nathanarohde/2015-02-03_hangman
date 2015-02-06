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
  if @word.alive == false
    erb :death
  elsif @word.victory == true
    erb :victory
  else
  @letter_range = ('a'..'z')
  erb :word
  end

end

patch '/reset_word' do
  @word = Word.find(params['id'])
  @word.word_reset

  redirect back
end

delete "/delete_word" do
  @word = Word.find(params['id'])
  @word.delete_word

  redirect'/'
end

post '/guessed_letter' do
  @word = Word.find(params['id'])
  @submitted_guessed_letter = params['guessed_letter']
  @guessed_letter = GuessedLetter.create({:letter => @submitted_guessed_letter, :word_id => @word.id})
  @word.reload()
  if @word.alive == false
    erb :death
  elsif @word.victory == true
    erb :victory
  else
    redirect back
  end

end
