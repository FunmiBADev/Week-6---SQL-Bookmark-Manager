require 'bookmark'
require 'setup_test_database'
require 'database_helpers_spec'

describe Bookmark do 
	describe '.list_all' do 
		it 'returns all bookmarks' do 
			connection = PG.connect(dbname: 'bookmark_manager_test')

			bookmark = Bookmark.create(url: 'https://makers.tech', title: 'Makers Academy')
    	Bookmark.create(url:'http://www.google.com', title: 'Google')
    	Bookmark.create(url:'http://www.destroyallsoftware.com', title: 'Destroy All Software')

			bookmarks = Bookmark.list_all

			expect(bookmarks.length).to eq 3
			expect(bookmarks.first).to be_a Bookmark
			expect(bookmarks.first.id).to eq bookmark.id 
			expect(bookmarks.first.title).to eq 'Makers Academy'
			expect(bookmarks.first.url).to eq "https://makers.tech"
    	
		end
	end

	describe '.create' do 
		it 'creates a new bookmark' do 
			bookmark = Bookmark.create(url: 'http://testbookmark.com', title: 'Test Bookmark')
			persisted_data = persisted_data(id: bookmark.id)

			expect(bookmark).to be_a Bookmark
			expect(bookmark.id).to eq persisted_data.first['id']
			expect(bookmark.url).to eq 'http://testbookmark.com'
			expect(bookmark.title).to eq 'Test Bookmark'
		end
	end

	describe '.delete' do 
		it 'deletes the selected bookmark' do 
			bookmark = Bookmark.create(url: 'https://makers.tech', title: 'Makers Academy')

			Bookmark.delete(id: bookmark.id)

			expect(Bookmark.list_all.length).to eq 0
		end
	end

end
