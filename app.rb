require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

	 get '/bookmarks' do
	 	p ENV

    @bookmarks = Bookmark.list_all 
    erb :'bookmarks/index'
  end


  run! if app_file == $0
end
