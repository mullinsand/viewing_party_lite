require 'rails_helper'

RSpec.describe 'Admin Users show page' do
  
  describe 'as an admin' do
    describe 'when I visit other users dashboards' do
      it 'I see the exact same thing that the user does' do
        @admin = create(:user, email: 'kit.kat@guhmail.com', password: 'Test', role: 'admin')
        @users = create_list(:user, 5)
        
        visit login_path
        fill_in 'Email:', with: @admin.email
        fill_in 'Password:', with: @admin.password
        click_button 'Log In'

        visit admin_user_path(@users[0])

        expect(current_path).to eq(admin_user_path(@users[0]))
        expect(page).to have_content('Hosted Viewing Parties')
      end
    end
  end
  
  describe 'as a visitor/registered user' do
    context 'when I visit other users admin dashboards' do
      it 'I am taken back to the landing with an unathorized message' do
        @user = create(:user, email: 'kit.kat@guhmail.com', password: 'Test')
        
        visit login_path
        fill_in 'Email:', with: @user.email
        fill_in 'Password:', with: @user.password
        click_button 'Log In'
        visit admin_user_path(@user)
        expect(current_path).to eq(root_path)
        expect(page).to have_content('You are not authorized to access these pages')
      end
    end
  end
end