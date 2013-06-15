require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid data' do
      before { click_button 'Sign in' }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visting another page" do
        before { click_link "Home" }

        it { should_not have_selector('div.alert.alert-error', text: 'Invalid') }
      end
    end

    describe 'with valid data' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      it { should have_link('Users', href: users_path ) }
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user) ) }
      it { should have_link('Settings', href: edit_user_path(user) ) }
      it { should have_link('Sign out', href: signout_path ) }
      it { should_not have_link('Sign in', href: signin_path ) }


      describe 'after signout' do
        before { click_link 'Sign out' }
        it { should have_link('Sign in') }
      end
    end
  end

  describe 'authorization' do
    describe 'not signed in' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'attempt to visit protected page' do
        before do
          visit edit_user_path(user)
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        describe 'after signin' do
          it 'should render correct target page' do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end

      describe 'in users controller' do
        describe 'visit edit user' do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe 'submit update' do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end

        describe 'visit user index' do
          before {visit users_path }
          it { should have_selector('title', text: 'Sign in') }
        end
      end

      describe 'as wrong user' do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong.email@email.com') }

        before {sign_in user}

        describe 'visit edit #user page' do
          before { visit edit_user_path(wrong_user) }
          it { should_not have_selector('title', text: full_title('Edit user'))}
        end

        describe 'put for wrong user' do
          before { put user_path(wrong_user) }
          it { response.should redirect_to(root_url)}
        end
      end
    end

    describe 'as non-admin user' do
      let(:user) { FactoryGirl.create :user }
      let(:non_admin) { FactoryGirl.create :user }

      before do
        sign_in non_admin
      end

      describe 'attempt to delete user' do
        before do
          delete user_path(user)
        end
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
