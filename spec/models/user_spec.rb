require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "should save a user with all fields set" do
      user = User.new(name: "John Doe", email: "john.doe@email.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
    end

    it "should validate the presence of a name" do
      user = User.new(name: nil, email: "john.doe@email.com", password: "password", password_confirmation: "password")
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it "should validate the presence of an email" do
      user = User.new(name: "John Doe", email: nil, password: "password", password_confirmation: "password")
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "should validate the uniqueness of an email" do
      user1 = User.new(name: "John Doe", email: "j.doe@email.com", password: "password", password_confirmation: "password")
      user1.save
      user2 = User.new(name: "Jane Doe", email: "j.doe@email.com", password: "password", password_confirmation: "password")
      user2.save
      user2.valid?
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should validate the presence of a password" do
      user = User.new(name: "John Doe", email: "john.doe@email.com", password: nil, password_confirmation: "password")
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "should validate the presence of a password confirmation" do
      user = User.new(name: "John Doe", email: "john.doe@email.com", password: "password", password_confirmation: nil)
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "should validate the password and password confirmation match" do
      user = User.new(name: "John Doe", email: "john.doe@email.com", password: "password", password_confirmation: "password")
      
      expect(user.password).to eq(user.password_confirmation)
    end
  end

  describe '.authenticate_with_credentials' do

    it "should authenticate a user with the correct email and password" do
      user = User.new(name: "John Doe", email: "john.doe@email.com", password: "password", password_confirmation: "password")
      user.save
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end

    it "should authenticate a user with the correct email and password with trailing whitespace" do
      user = User.create(name: "John Doe", email: "john.doe@email.com", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials("john.doe@email.com  ", "password")).to eq(user)
    end

    it "should authenticate a user with the correct email and password with leading whitespace" do
      user = User.create(name: "John Doe", email: "john.doe@email.com", password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials("  john.doe@email.com", "password")).to eq(user)
    end

    it "should authenticate a user with the correct email and password with different case" do
      user = User.create(name: "John Doe", email: "john.doe@email.com".downcase, password: "password", password_confirmation: "password")
      expect(User.authenticate_with_credentials("JoHn.DoE@eMAiL.CoM", "password")).to eq(user)
    end
    
  end
end