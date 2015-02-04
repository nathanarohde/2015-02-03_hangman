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
  @guessed_letter = params['guessed_letter']
  @word.word_letters.each do |wordletter|
    if wordletter.letter == @guessed_letter
      wordletter.update({:guessed => true})
    else

    end
  end

  redirect back
end
