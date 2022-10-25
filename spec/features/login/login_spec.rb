require 'rails_helper'

RSpec.describe 'Login Page' do

  


  describe 'As a registered user when I visit the login page' do
    before(:each) do
      @user = create(:user, email: 'kit.kat@guhmail.com', password: 'Test')
      visit login_path
    end

    it 'I see a place to input email and password' do
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

    context 'filling in correct email and password' do
      it 'redirect registered user to their dashboard' do

        fill_in 'Email:', with: @user.email
        fill_in 'Password:', with: 'Test'
        click_button 'Log In'
  
        expect(current_path).to eq(dashboard_path(@user))
      end
    end

    context 'filling in correct email and incorrect password' do
      it 'redirect registered user back to login page with error message' do

        fill_in 'Email:', with: @user.email
        fill_in 'Password:', with: 'Test1'
        click_button 'Log In'
  
        expect(current_path).to eq(login_path)
        expect(page).to have_content('Incorrect password')
      end
    end

    context 'filling in incorrect email' do
      it 'redirect registered user back to login page with error message' do

        fill_in 'Email:', with: 'user@email.stuff'
        fill_in 'Password:', with: 'Test1'
        click_button 'Log In'
  
        expect(current_path).to eq(login_path)
        expect(page).to have_content('Invalid Email')
      end
    end
  end
end