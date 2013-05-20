require 'spec_helper'

describe "Static Pages" do
  subject { page }
  let(:page_title) { heading }

  shared_examples 'all static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

	describe 'home' do
    before { visit root_path }
    let(:heading) { 'Sample App'}
    let(:page_title) { ''}

    it_should_behave_like 'all static pages'
    it { should_not have_selector('title', text: " | Home") }
	end

	describe 'help' do
    before { visit help_path }
    let(:heading) { 'Help'}
    it_should_behave_like 'all static pages'
	end

	describe 'about' do
    before { visit about_path }
    let(:heading) { 'About'}
    it_should_behave_like 'all static pages'
	end

	describe 'contact' do
    before { visit contact_path }
    let(:heading) { 'Contact'}
    it_should_behave_like 'all static pages'
	end

  it 'should have valid links' do
    visit root_path
    click_link 'About'
    page.should have_selector 'title', text: full_title('About') 
    click_link 'Help'
    page.should have_selector 'title', text: full_title('Help') 
    click_link 'Contact'
    page.should have_selector 'title', text: full_title('Contact') 
    click_link 'Home'
    page.should have_selector 'title', text: full_title('') 
    click_link 'Sign up now!'
    page.should have_selector 'title', text: full_title('Sign up') 
    click_link 'Sample App'
    page.should have_selector 'title', text: full_title('') 
  end
end
