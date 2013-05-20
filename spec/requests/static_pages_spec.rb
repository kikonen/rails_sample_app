require 'spec_helper'

describe "StaticPages" do
  describe 'static pages' do
  	describe 'home' do
  	  it 'should have content "sample app"' do
  	  	visit '/static_pages/home'
  	  	page.should have_selector('h1', text: 'Sample App')
  	  end

  	  it 'should have right title' do
  	  	visit '/static_pages/home'
  	  	page.should have_selector('title', text: 'Sample App | Home')
  	  end
  	end

  	describe 'help' do
  	  it 'should have content "help"' do
  	  	visit '/static_pages/help'
  	  	page.should have_selector('h1', text: 'Help')
  	  end

  	  it 'should have right title' do
  	  	visit '/static_pages/help'
  	  	page.should have_selector('title', text: 'Sample App | Help')
  	  end
  	end

  	describe 'about' do
  	  it 'should have content "about"' do
  	  	visit '/static_pages/about'
  	  	page.should have_selector('h1', text: 'About Us')
  	  end

  	  it 'should have right title' do
  	  	visit '/static_pages/about'
  	  	page.should have_selector('title', text: 'Sample App | About')
  	  end
  	end
  end

end
