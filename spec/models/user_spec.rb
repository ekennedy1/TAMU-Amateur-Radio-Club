require 'rails_helper'

RSpec.describe User, type: :model do

  context "Validations" do
    it "is valid with valid attributes" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: '123456')
      expect(user).to be_valid
    end

    it "is not valid without a first_name" do
      user = User.new(fname: nil, lname: "Doe", email: "test@gmail.com", role: "Admin", password: '123456')
      expect(user).not_to be_valid
    end

    it "is not valid without a last_name" do
      user = User.new(fname: "John", lname: nil, email: "test@gmail.com", role: "Admin", password: '123456')
      expect(user).not_to be_valid
    end
    
    it "is not valid without an email" do
      user = User.new(fname: "John", lname: "Doe", email: nil, role: "Admin", password: '123456')
      expect(user).not_to be_valid
    end
    
    it "is not valid without a role" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: nil, password: '123456')
      expect(user).not_to be_valid
    end

    it "is not valid with a duplicate email" do
      User.create!(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: '123456')
      user = User.new(fname: "Jane", lname: "Doe", email: "test@gmail.com", role: "Member", password: '123456')
      expect(user).not_to be_valid
    end
    
    it "is not valid without a password" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: nil)
      expect(user).not_to be_valid
    end
    
    it "is not valid with a short password" do
      user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: "Admin", password: '12345')
      expect(user).not_to be_valid
    end

    # it "is only valid with role as 'Admin' or 'Member'" do
    #   user = User.new(fname: "John", lname: "Doe", email: "test@gmail.com", role: "InvalidRole", password: '123456')
    #   expect(user).not_to be_valid
    # end
  end
end
