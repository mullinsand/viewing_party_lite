require 'rails_helper'

RSpec.describe 'Movie Details Page' do
  describe 'As a user when I visit the movie details page' do
    before(:each) do
      @user = create(:user, email: 'kit.kat@guhmail.com', password: 'Test')

      visit login_path
      fill_in 'Email:', with: @user.email
      fill_in 'Password:', with: @user.password
      click_button 'Log In'
      VCR.use_cassette('fight_club_movie_data_v2') do
        @fight_club = double(id: 550, title: 'Fight Club')
        visit dashboard_movie_path(@fight_club.id)
      end
    end
    it 'I see a button to create a viewing party' do
      expect(page).to have_button("Create Viewing Party for Fight Club")
    end

    it 'I see a button to return to the Discover Page' do
      expect(page).to have_button("Discover Page")
    end

    it 'has a header for the movie title' do
      expect(page).to have_content("Fight Club")
    end

    it 'I see the vote Average of the movie' do
      expect(page).to have_content("Vote Average: 8.427")
    end

    it 'I see the runtime in hours & minutes of the movie' do
      expect(page).to have_content("Runtime: 2h 19min")
    end

    it 'I see the genre(s) associated to the movie' do
      within("#genre") do
        expect(page).to have_content("Genre(s):")
        expect(page).to have_content("Drama")
        expect(page).to have_content("Thriller")
        expect(page).to have_content("Comedy")
      end
    end

    it 'I see the list the summary for the movie' do
      expect(page).to have_content("Summary")
    end

    it 'I see the list the first 10 cast members (characters&actress/actors) in the movie' do
      within("#cast") do
        expect(page).to have_content("Cast")
        expect(page).to have_content("Edward Norton / The Narrator")
        expect(page).to have_content("Brad Pitt / Tyler Durden")
        expect(page).to have_content("Helena Bonham Carter / Marla Singer")
        expect(page).to have_content("Jared Leto / Angel Face")
        expect(page).to have_content("Zach Grenier / Richard Chesler")
        expect(page).to have_content("Holt McCallany / The Mechanic")
        expect(page).to have_content("Eion Bailey / Ricky")
        expect(page).to have_content("Richmond Arquette / Intern")
        expect(page).to have_content("David Andrews / Thomas")
      end
    end

    it 'I see the count of total reviews for the movie' do
      expect(page).to have_content("7 Reviews")
    end

    it 'I see each reviews author and information for the movie' do
      within("#reviews") do
        expect(page).to have_content("Author: Goddard")
        expect(page).to have_content("Author: Brett Pascoe")
        expect(page).to have_content("Author: MSB")
        expect(page).to have_content("Author: r96sk")
        expect(page).to have_content("Author: rsanek")
        expect(page).to have_content("Author: Wuchak")
        expect(page).to have_content("Author: katch22")
      end
    end
  end
end
