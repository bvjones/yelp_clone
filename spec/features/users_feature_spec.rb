require 'rails_helper'

feature 'User can sign in and out' do
  context 'user not signed in and on the homepage' do
    it 'should see a "sign in" link and a sign up link' do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it 'should not see sign out link' do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      signup_and_in
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
  
  context 'user has not signed in' do
   scenario 'user cannot create, edit, review or delete a restaurant entry if not logged in' do
     visit('/')
     click_link('Add a restaurant')
     expect(page).to have_content 'You need to sign in or sign up before continuing.'
   end
 end
end
