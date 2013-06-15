require 'spec_helper'


describe 'UserPages' do
  subject { page }

  describe 'index' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1', text: 'All users') }

    describe 'pagination' do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it 'should list all users' do
        User.paginate(page: 1) do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe 'delete links' do
      it { should_not have_link 'delete' }

      describe 'as admin' do
        let(:admin) { FactoryGirl.create :admin }
        before do
          user
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it 'should be able to delete another user' do
          expect { click_link 'delete' }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe 'signup' do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up')}
    it { should have_selector('title', text: full_title('Sign up'))}
  end

  describe 'profile' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name)}
    it { should have_selector('title', text: user.name)}
  end

  describe 'signup' do
    before { visit signup_path }
    let(:submit) { "Create My Account" }

    describe 'with invalid data' do
      it 'should not create user' do
        expect { click_button submit }.not_to change(User, :count)
      end

    end

    describe 'after submission' do
      before { click_button submit }

      it { should have_selector('title', text: ' Sign up') }
      it { should have_content('error') }
      it { should have_content("Password can't be blank") }
      it { should have_content("Name can't be blank") }
      it { should have_content("Email can't be blank") }
      it { should have_content("Email is invalid") }
      it { should have_content("Password is too short (minimum is 6 characters)") }
      it { should have_content("Password confirmation can't be blank") }
    end

    describe 'with valid data' do
      before do
        fill_in 'Name',         with: 'Example User'
        fill_in 'Email',        with: 'user@example.com'
        fill_in 'Password',     with: 'foobar'
        fill_in 'Confirm Password', with: 'foobar'
      end

      it 'should create user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving user' do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe 'page' do
      it { should have_selector('h1',    text: 'Update your profile')}
      it { should have_selector('title', text: 'Edit user')}
      it { should have_link('change',    href: 'http://gravatar.com/emails')}
    end

    describe 'with invalid info' do
      before { click_button 'Save changes' }

      it { should have_content('error') }
    end

    describe 'with valid info' do
      let(:new_name) { 'New Name' }
      let(:new_email) { 'new.email@email.com' }

      before do
        fill_in 'Name', with: new_name
        fill_in 'Email', with: new_email
        fill_in 'Password', with: user.password
        fill_in 'Confirm Password', with: user.password
        click_button 'Save changes'
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }

      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email.downcase }
    end
  end
end
