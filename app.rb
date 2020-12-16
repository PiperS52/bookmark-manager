require 'sinatra/base'  

require './lib/bookmarks'

class App < Sinatra::Base

  get '/' do
    "Hello World"
  end 

  get '/bookmarks' do
    @bookmarks = Bookmarks.all  

    erb :bookmarks
  end 
end
