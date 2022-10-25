require 'rails_helper'

RSpec.describe 'Admin dashboard' do
  
  describe 'as an admin' do
    context'when I successfully login' do
      before :each do
        @admin = create(:user, email: 'kit.kat@guhmail.com', password: 'Test', role: 'admin')
        @users = create_list(:user, 5)
        
        visit login_path
        fill_in 'Email:', with: @admin.email
        fill_in 'Password:', with: @admin.password
        click_button 'Log In'
      end
      it 'I am taken to my dashboard' do

        expect(current_path).to eq(admin_dashboard_path)
      end

      it 'I see a list of all default users email addresses' do
        within '#default_users_emails' do
          @users.each do |user|
            expect(page).to have_link(user.email)
          end
        end
      end

      it 'each email address is a link to the admin users dashboard' do
        within '#default_users_emails' do
          @users.each do |user|
            within "user_#{user.id}" do
              click_link(user.email)
              expect(current_path).to eq(admin_user_path(user))
              visit admin_dashboard_path
            end
          end
        end
      end
    end
  end
  
  describe 'as a visitor/registered user' do
    context 'when I visit the admin dashboard' do
      it 'I am taken back to the landing with an unathorized message' do
        @user = create(:user, email: 'kit.kat@guhmail.com', password: 'Test')
        
        visit login_path
        fill_in 'Email:', with: @user.email
        fill_in 'Password:', with: @user.password
        click_button 'Log In'
        visit admin_dashboard_path
        expect(current_path).to eq(root_path)
        expect(page).to have_content('You are not authorized to access these pages')
      end
    end
  end
end