require 'sinatra/base'  

require './lib/bookmarks'

class App < Sinatra::Base

  get '/' do
    erb :index
  end 

  get '/bookmarks' do
    @bookmarks = Bookmarks.all  

    erb :bookmarks
  end

  get '/bookmarks/new' do
    erb :bookmarks_new
  end

  post '/bookmarks' do
    Bookmarks.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
