require 'spec_helper'

describe ApplicationHelper do
  describe 'full_title' do
    it 'should include page title' do
      full_title('foo').should =~ /foo/
    end

    it 'should include base title' do
      full_title('foo').should =~ /^Sample App/
    end

    it 'should not include bar for home' do
      full_title('').should_not =~ /\|/
    end
  end
  
end