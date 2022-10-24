# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The register new user page' do
  before(:each) do
    visit register_path
  end

  describe 'As a user when I visit this page' do
    it 'I see a Register New User header' do
      expect(page).to have_content('Register a New User')
    end

    it 'I see a form to register a new user' do
      expect(page.has_field?).to eq(true)

      expect(page).to have_content('Name:')
      expect(page).to have_content('Email:')
      expect(page).to have_content('Password:')
      expect(page).to have_content('Password Confirmation:')
    end

    describe 'I can fill out the form' do
      context 'if all info is entered properly in form' do
        it 'when I click the register button I am redirected to the dashboard page' do
          fill_in 'Name:', with: 'Kat'
          fill_in 'Email:', with: 'kit.kat@guhmail.com'
          fill_in 'Password:', with: 'Test'
          fill_in 'Password Confirmation:', with: 'Test'
          click_button 'Create User'
    
          expect(current_path).to eq(user_path(User.find_by(user_name: 'Kat')))
        end
      end
      context 'if email has already been used' do
        it 'when I click the register button I am redirected back register page if that email has been taken' do
          @kat = User.create!(user_name: 'Kat', email: 'kit.kat@guhmail.com')
    
          fill_in 'Name:', with: 'Kit'
          fill_in 'Email:', with: 'kit.kat@guhmail.com'
          fill_in 'Password:', with: 'Test'
          fill_in 'Password Confirmation:', with: 'Test'
          click_button 'Create User'
    
          expect(current_path).to eq(register_path)
          expect(page).to have_content('Email has already been taken')
        end
      end
    end
    
  end
end
