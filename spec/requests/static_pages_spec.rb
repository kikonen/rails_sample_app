require 'spec_helper'

describe "Static Pages" do
  subject { page }

	describe 'home' do
    before(:each) { visit root_path }

	  it { should have_selector('h1', text: 'Sample App') }
	  it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: " | Home") }
	end

	describe 'help' do
    before(:each) { visit help_path }

	  it { should have_selector('h1', text: 'Help') }
	  it { should have_selector('title', text: full_title('Help')) }
	end

	describe 'about' do
    before(:each) { visit about_path }

	  it { should have_selector('h1', text: 'About Us') }
	  it { should have_selector('title', text: full_title('About')) }
	end

	describe 'contact' do
    before(:each) { visit contact_path }

	  it { should have_selector('h1', text: 'Contact') }
	  it { should have_selector('title', text: full_title('Contact')) }
	end
end
