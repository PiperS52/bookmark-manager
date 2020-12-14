require 'sinatra/base'

class App < Sinatra::Base

  get '/' do
    "Hello World"
  end 

  get '/bookmarks' do
    "Hello World"
  end 
end
