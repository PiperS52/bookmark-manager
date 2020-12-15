require 'sinatra/base'  

require './lib/bookmarks'

class App < Sinatra::Base

  get '/' do
    "Hello World"
  end 

  get '/bookmarks' do
    @bookmarks = Bookmarks.new

    erb :bookmarks
  end 
end
