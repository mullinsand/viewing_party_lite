require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  describe 'As a user when I visit the discover movies page' do
    before :each do
      @user = create(:user, email: 'kit.kat@guhmail.com', password: 'Test')

      visit login_path
      fill_in 'Email:', with: @user.email
      fill_in 'Password:', with: @user.password
      click_button 'Log In'
    end

    it 'has a Discover Movies header' do

      visit discover_dashboard_path(@user)

      expect(page).to have_content('Discover Movies')
    end

    it 'should have a button for top rated movies' do

      visit discover_dashboard_path(@user)

      expect(page).to have_button("Top Rated Movies")
    end

    it 'current_path should have a section for top rated movies' do
      VCR.use_cassette('top_40_movies') do


        visit discover_dashboard_path(@user)
        expect(page).to_not have_css("#top_40_movies")
        # save_and_open_page
        click_button "Top Rated Movies"

        expect(page).to have_css("#top_40_movies")
        expect(page).to have_button("Discover Page")
      end
    end

    it 'has a search bar' do
      VCR.use_cassette('search') do


        visit discover_dashboard_path(@user)
        expect(page).to have_button('Find Movies')

        page.fill_in with: "fight cLub"
        click_button 'Find Movies'
        expect(current_path).to eq discover_dashboard_path(@user)
        expect(page).to have_content "Fight Club"
      end
    end

    it 'has button to navigate back to the discover page' do
      VCR.use_cassette('search') do


        visit discover_dashboard_path(@user)
        expect(page).to have_button('Find Movies')

        page.fill_in with: "fight cLub"
        click_button 'Find Movies'

        within("#search_results") do
          expect(page).to have_button "Discover Page"
          click_button "Discover Page"
        end

        expect(current_path).to eq discover_dashboard_path(@user)
      end
    end

    it 'should be able to navigate to the discover page' do
      VCR.use_cassette('top_40_discover') do


        visit discover_dashboard_path(@user)

        click_button "Top Rated Movies"
        expect(page).to have_button("Discover Page")
        click_button "Discover Page"

        expect(current_path).to eq discover_dashboard_path(@user)
      end
    end

    it 'should be able to navigate to the discover page' do
      VCR.use_cassette('dashboard_movies_show_page') do

        visit discover_dashboard_path(@user)
        
        click_button "Top Rated Movies"

        click_link "The Godfather"

        expect(current_path).to eq dashboard_movie_path(238)
      end
    end

    it 'it returns a message on the page' do
      VCR.use_cassette('search_no_searches') do


        visit discover_dashboard_path(@user)

        page.fill_in with: "supercalir"
        click_button 'Find Movies'

        within("#search_results") do
          expect(page).to have_content("No Movies Found, Please Try Again")
        end
      end
    end
  end
end
