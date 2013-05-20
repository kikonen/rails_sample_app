require 'spec_helper'

describe "StaticPages" do
  describe 'static pages' do
  	let(:base_title) {'Sample App'}

  	describe 'home' do
  	  it 'should have content "sample app"' do
  	  	visit '/static_pages/home'
  	  	page.should have_selector('h1', text: 'Sample App')
  	  end

  	  it 'should have right title' do
  	  	visit '/static_pages/home'
  	  	page.should have_selector('title', text: "#{base_title}")
  	  end

      it 'should not have extension title' do
        visit '/static_pages/home'
        page.should_not have_selector('title', text: " | Home")
      end
  	end

  	describe 'help' do
  	  it 'should have content "help"' do
  	  	visit '/static_pages/help'
  	  	page.should have_selector('h1', text: 'Help')
  	  end

  	  it 'should have right title' do
  	  	visit '/static_pages/help'
  	  	page.should have_selector('title', text: "#{base_title} | Help")
  	  end
  	end

  	describe 'about' do
  	  it 'should have content "about"' do
  	  	visit '/static_pages/about'
  	  	page.should have_selector('h1', text: 'About Us')
  	  end

  	  it 'should have right title' do
  	  	visit '/static_pages/about'
  	  	page.should have_selector('title', text: "#{base_title} | About")
  	  end
  	end

  	describe 'contact' do
  	  it 'should have content "contact"' do
  	  	visit '/static_pages/contact'
  	  	page.should have_selector('h1', text: 'Contact')
  	  end

  	  it 'should have right title' do
  	  	visit '/static_pages/contact'
  	  	page.should have_selector('title', text: "#{base_title} | Contact")
  	  end
  	end
  end

end
