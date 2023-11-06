require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".from_google" do
    let(:auth) { OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '1234567890', info: { email: 'test@gmail.com', name: 'Test User' }) }

    # Sunny Case: Tests the ideal scenario where a new user is created because they do not already exist.
    it "creates a new user if one doesn't exist" do
      expect { User.from_google(email: auth.info.email, full_name: auth.info.name, uid: auth.uid) }.to change { User.count }.by(1)
    end

    # Sunny Case: Tests the expected behavior of returning an already existing user when one is present.
    it "returns an existing user if one exists" do
      user = User.create!(fname: 'Test', lname: 'User', email: auth.info.email, role: 'Admin', password: '123456', uid: auth.uid)
      expect(User.from_google(email: auth.info.email, full_name: auth.info.name, uid: auth.uid)).to eq(user)
    end

    context "with non-allowed email domains" do
      let(:yahoo_auth) { OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '9876543210', info: { email: 'test@yahoo.com', name: 'Test Yahoo' }) }

      # Rainy Case: Tests an undesired situation where a non-allowed domain (yahoo.com) is used. The user should not be created.
      it "doesn't create a user with yahoo.com email" do
        expect { User.from_google(email: yahoo_auth.info.email, full_name: yahoo_auth.info.name, uid: yahoo_auth.uid) }.not_to change { User.count }
      end
    end

    context "with incomplete full_name" do
      let(:first_name_auth) { OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: '5555555555', info: { email: 'firstonly@gmail.com', name: 'Firstonly' }) }

      # Sunny Case (assuming the application supports users with only first names): This tests the scenario where a user only provides a first name and it should still proceed to create a new user.
      it "handles users with only first name" do
        expect { User.from_google(email: first_name_auth.info.email, full_name: first_name_auth.info.name, uid: first_name_auth.uid) }.to change { User.count }.by(1)
      end
    end
end


  context "Validations" do
    # Sunny Test
    it "is valid with valid attributes" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: '123456')
      expect(user).to be_valid
    end

    # Rainy Test
    it "is not valid without a first_name" do
      user = User.new(fname: nil, lname: "Doe", email: "test@gmail.com", role: "Admin", password: '123456')
      expect(user).not_to be_valid
    end

    # Rainy Test
    it "is not valid without a last_name" do
      user = User.new(fname: "John", lname: nil, email: "test@gmail.com", role: "Admin", password: '123456')
      expect(user).not_to be_valid
    end

    # Rainy Test
    it "is not valid without an email" do
      user = User.new(fname: "John", lname: "Doe", email: nil, role: "Admin", password: '123456')
      expect(user).not_to be_valid
    end

    # Rainy Test
    it "is not valid without a role" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: nil, password: '123456')
      expect(user).not_to be_valid
    end

    # Rainy Test
    it "is not valid with a duplicate email" do
      User.create!(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: '123456')
      user = User.new(fname: "Jane", lname: "Doe", email: "test@gmail.com", role: "Member", password: '123456')
      expect(user).not_to be_valid
    end

    # Rainy Test
    it "is not valid without a password" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: nil)
      expect(user).not_to be_valid
    end

    # Rainy Test
    it "is not valid with a short password" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: '12345')
      expect(user).not_to be_valid
    end
  end
end
