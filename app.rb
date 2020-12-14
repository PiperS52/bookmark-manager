require 'sinatra/base'  

require './lib/bookmarks'

class App < Sinatra::Base

  get '/' do
    "Hello World"
  end 

  get '/bookmarks' do
    @bookmarks = Bookmarks.new  
    @bookmarks.show_list

    erb :bookmarks
  end 
end
