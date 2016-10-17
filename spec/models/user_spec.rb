require 'rails_helper'

RSpec.feature "User", :type => :feature do
  scenario "passwords match" do
    visit "/users/new"

    fill_in "user[first_name]", :with => "Ben"
    fill_in "user[last_name]", :with => "Chu"
    fill_in "user[email]", :with => "2"
    fill_in "user[password]", :with => "1234"
    fill_in "user[password_confirmation]", :with => "1234"

    click_button "Submit"

    expect(page).to have_text("Ben")
  end
  scenario "passwords dont match" do
    visit "/users/new"
    fill_in "user[first_name]", :with => "Ben"
    fill_in "user[last_name]", :with => "Chu"
    fill_in "user[email]", :with => "1"
    fill_in "user[password]", :with => "1234"
    fill_in "user[password_confirmation]", :with => "12345"
    click_button "Submit"
    expect(page).not_to have_text("Ben")
  end

  context "Email" do
    it 'checks if emails are unique- user2 created' do
      @user1 = User.create(first_name: 'Ben', last_name: 'chu', email:'test', password:'1234', password_confirmation:'1234')
      @user2 = User.create(first_name: 'B', last_name: 'chu', email:'bchuup', password:'1234', password_confirmation:'1234')
      expect(@user2.valid?).to eq(true)
    end

    it 'checks if emails are unique- user2 not created' do
      @user1 = User.create(first_name: 'Ben', last_name: 'chu', email:'test', password:'1234', password_confirmation:'1234')
      @user2 = User.create(first_name: 'Ben', last_name: 'chu', email:'test', password:'1234', password_confirmation:'1234')
      expect(@user2.valid?).to eq(false)
    end

    it 'checks if emails are not case senstive- user2 created' do
      @user1 = User.create(first_name: 'Ben', last_name: 'chu', email:'test', password:'password', password_confirmation:'PASSWORD')
      @user2 = User.create(first_name: 'Ben', last_name: 'chu', email:'TEST', password:'password', password_confirmation:'password')
      expect(@user2.valid?).to eq(true)
    end

    it 'checks if emails are at least 3- user2 not created' do
      @user2 = User.create(first_name: 'Ben', last_name: 'chu', email:'1234', password:'PA', password_confirmation:'PA')
      expect(@user2.valid?).to eq(false)
    end
  end

  context '.authenticate_with_credentials' do
    it 'should return the same user as the one who was created' do
      @user = User.create(first_name: 'Ben', last_name: 'chu', email:'1234', password:'password', password_confirmation:'password')
      @user1= User.authenticate_with_credentials('1234', 'password')
      expect(@user1).to eq(@user)
    end

    it 'should strip all spaces before and after and be case insenstive to emails' do
      @user = User.create(first_name: 'Ben', last_name: 'chu', email:'  1234EMail '.squish.downcase, password:'password', password_confirmation:'password')
      @user1 = User.authenticate_with_credentials('  1234EMail ', 'password')
      expect(@user1.email).to eq('1234email')
    end
  end

end


# validations
RSpec.describe User do
  describe User do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
  end
end



