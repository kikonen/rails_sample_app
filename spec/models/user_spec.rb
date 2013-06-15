# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before { @user = User.new(
      name: 'Example User',
      email: 'user@example.com',
      password: 'foobar',
      password_confirmation: 'foobar') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }

  it { should be_valid }
  it { should_not be_admin }

  describe 'with admin attribute set to true' do
    before do
      @user.save!
      @user.toggle! :admin
    end

    it { should be_admin }
  end

  describe 'name missing' do
    before { @user.name = ' ' }
    it { should_not be_valid }
  end

  describe 'name too long' do
    before { @user.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'email missing' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'email mixed case' do
    let(:mixed_case_email) { 'foo.BAR@zoo.COM' }

    it "should be valid" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email == mixed_case_email.downcase
    end
  end

  describe 'invalid email' do
    it "should not be valid" do
      addresses = %w[
        user.foo,com
        user_at_foo.org
        example.user@foo.
        foo@bar_baz.com
        foo@bar+baz.com]

      addresses.each do |addr|
        @user.email = addr
        @user.should_not be_valid
      end
    end
  end

  describe 'valid email' do
    it "should be valid" do
      addresses = %w[
        user@foo.COM
        A_US-ER@f.b.org
        frst.lst@foo.jp
        a+b@az.ch ]

      addresses.each do |addr|
        @user.email = addr
        @user.should be_valid
      end
    end
  end

  describe 'duplicate email' do
    before do
      dup_user = @user.dup
      dup_user.save
    end
    it { should_not be_valid}
  end

  describe 'duplicate email UPPER_CASE' do
    before do
      dup_user = @user.dup
      dup_user.email = dup_user.email.upcase
      dup_user.save
    end
    it { should_not be_valid}
  end

  describe 'password missing' do
    before { @user.password = @user.password_confirmation = ' ' }
    it { should_not be_valid }
  end

  describe 'password confirm mismatch' do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe 'password confirm nil' do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe 'too short password' do
    before { @user.password = @user.password_confirmation = 'az' }
    it { should be_invalid }
  end

  describe 'authenticate result' do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe 'valid password' do
      it { should == found_user.authenticate(@user.password) }
    end

    describe 'invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid pwd') }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe 'remember token' do
    before { @user.save }

    its(:remember_token) { should_not be_blank }
  end
end
