require 'rails_helper'

RSpec.describe 'Login Page' do
  before(:each) do
  end
  
  describe 'As a user when I visit the landing' do
    it 'I see a Log In button' do
      visit root_path
      expect(page).to have_content('Log In')
    end
  end

  describe 'As a registered user when I visit the login page' do
    it 'I see a place to input email and password' do
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
    end

    context 'filling in correct email' do

    end

    context 'filling in correct email and password' do

    end

    context 'filling in incorrect email' do

    end

    context 'filling in correct email and incorrect password' do

    end
  end
end