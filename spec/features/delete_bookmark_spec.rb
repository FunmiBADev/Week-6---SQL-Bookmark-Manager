require 'pg'

feature 'Deleting a bookmark' do 
	scenario ' A user can delete a bookmark' do 
		Bookmark.create(url: 'https://makers.tech', title: 'Makers Academy')
		visit('/bookmarks')
		expect(page).to have_link('Makers Academy', href:'https://makers.tech')
		
		first('.bookmark').click_button 'Delete'

		expect(current_path).to eq '/bookmarks'
		expect(page).to have_no_link('Makers Academy', href: 'https://makers.tech')

	end
end

