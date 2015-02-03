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
    letter.Wordletter.create({:letter => letter})
    letter.update({:word_id => @word.id})
  end

  redirect '/'
end

get '/word/:id' do
  @word = Word.find(params['id'])


  erb :word
end

delete "/delete_word" do
  @word = Word.find(params['id'])
  @word.destroy()
  redirect('/')
end
