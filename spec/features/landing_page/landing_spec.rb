# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Landing Page" do
  describe "As a user when I visit the Landing Page" do
    it 'I see the header for the page' do
      visit root_path
        
      expect(page).to have_content("Viewing Party Light")
    end

    describe 'Navigation Bar' do
      it 'should have a navigation bar' do
        visit root_path

        expect(page).to have_css('.topnav', text: 'Home', visible: true)
        expect(page).to have_css('.topnav', text: 'About', visible: true)
        expect(page).to have_css('.topnav', text: 'Viewing Party Light', visible: true)
      end

      it 'home button should navigate to landing page' do
        visit root_path

        # save_and_open_page
        click_link 'Home'
        expect(current_path).to eq root_path
      end

      it 'about button should navigate to about page' do
        visit root_path

        click_link 'About'

        expect(current_path).to eq about_path
      end
    end

    describe 'Create New User button' do
      it 'should have a button to create a new user' do
        visit root_path

        expect(page).to have_button("Create New User")
      end

      it 'should link to the user#new page' do
        visit root_path

        click_button "Create New User"

        expect(current_path).to eq('/register')
      end
    end

    describe 'existing users' do
      context 'as a visitor' do
        it 'I do not see a list of existing users' do
          visit root_path
          expect(page).to_not have_css("#existing-users")
        end
      end

      context 'as a registered (logged in) user' do
        it 'should have a section for existing users with their emails' do
          @user = create(:user)
          users = User.all
          visit login_path
          fill_in 'Email:', with: @user.email
          fill_in 'Password:', with: @user.password
          click_button 'Log In'

          visit root_path
  
          within("#existing-users") do
            expect(page).to have_content("Existing Users")
          end

          within("#existing-users") do
            users.each do |user|
              expect(page).to have_content(user.email)
            end
          end
        end
      end
    end

    describe 'As a user when I visit the landing' do
      it 'I see a Log In button' do
        visit root_path
        # save_and_open_page
        expect(page).to have_button('Log In')
      end
    end

    describe 'has log out function' do
      before :each do 
        @user = create(:user)

        visit login_path
        fill_in 'Email:', with: @user.email
        fill_in 'Password:', with: @user.password
        click_button 'Log In'
      end

      context 'when user is logged in' do
        it 'does not have link to log in or create an account' do
          visit root_path
          # save_and_open_page
          expect(page).to_not have_button('Log In')
          expect(page).to_not have_button('Create New User')
        end

        it 'does have a link to log out' do
          visit root_path
          # save_and_open_page
          expect(page).to have_button('Log Out')
        end

        context 'pressing log out link' do
          it 'returns user to landing page where log in/register links are active' do
            visit root_path
            # save_and_open_page
            click_button 'Log Out'
            expect(current_path).to eq(root_path)
            expect(page).to have_button('Log In')
          end
        end
      end
    end
  end
end
