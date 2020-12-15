require 'sinatra/base'  

require './lib/bookmarks'

class App < Sinatra::Base

  get '/' do
    "Hello World"
  end 

  get '/bookmarks' do
<<<<<<< HEAD
    @bookmarks = Bookmarks.new
=======
    @bookmarks = Bookmarks.all  
>>>>>>> 0023f02a30df7fad2d1298366f3d74fcad50eebb

    erb :bookmarks
  end 
end
