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
  @letters_of_word = @word.word.split(//)
  @letters_of_word.each() do |letter|
    Wordletter.create({:letter => letter, :word_id => @word.id})
  end

  redirect '/'
end

get '/word/:id' do
  @word = Word.find(params['id'])
  @letter_range = ('a'..'z')

  erb :word
end

delete "/delete_word" do
  @word = Word.find(params['id'])
  @word.destroy()
  redirect'/'
end

post '/guessed_letter' do
  @word = Word.find(params['id'])
  @guessed_letter = params['guessed_letter']
    @word.wordletters.each do |wordletter|
      if wordletter.letter == @guessed_letter
        wordletter.update({:guessed => true})
      else

      end
    end

  redirect back
end
