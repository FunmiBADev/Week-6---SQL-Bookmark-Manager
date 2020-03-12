require 'pg'
require 'database_helpers_spec'
class Bookmark
	attr_reader :id, :title, :url

	def initialize(id:, title:, url:)
		@id = id
		@title = title
		@url = url
	end



	def self.list_all
		if ENV['ENVIRONMENT'] = 'test'
		connection = PG.connect(dbname: 'bookmark_manager_test')
	else
		connection = PG.connect(dbname: 'bookmark_manager')
	end

		result = connection.exec("SELECT * FROM bookmarks;")
		result.map do |bk| 
			Bookmark.new(id: bk['id'], title: bk['title'], url: bk['url']) 
		end
	end

	def self.create(url:, title:)
	
		if ENV['ENVIRONMENT'] == 'test'
		connection = PG.connect(dbname: 'bookmark_manager_test')
		else
		connection = PG.connect(dbname: 'bookmark_manager')
	end

	result = connection.exec("INSERT INTO bookmarks (title, url) VALUES ('#{title}','#{url}') RETURNING id, url, title;")
	Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
end
end