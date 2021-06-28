require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it 'is valid if all attributes are valid' do
      user = User.new(
        first_name: "Josh",
        last_name: "Peck",
        email: "josh@josh.com",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(user).to be_valid
    end
    it "is invalid if the first_name attribute is omitted" do
      user = User.new(
        first_name: nil,
        last_name: "Johnson",
        email: "noName@gmail.com",
        password: "123456",
        password_confirmation: "123456"
      )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include "First name can't be blank"
    end
    it "is invalid if the last_name attribute is omitted" do
      user = User.new(
        first_name: "Cher",
        last_name: nil,
        email: "Cher@gmail.com",
        password: "123456",
        password_confirmation: "123456"
      )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include "Last name can't be blank"
    end
    it "is invalid if the email attribute is omitted" do
      user = User.new(
        first_name: "Johnny",
        last_name: "Cash",
        email: nil,
        password: "123456",
        password_confirmation: "123456"
      )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include "Email can't be blank"
    end
    it "is invalid if the password attribute is omitted" do
      user = User.new(
        first_name: "Tom",
        last_name: "Petty",
        email: "tom@gmail.com",
        password: nil,
        password_confirmation: "123456"
      )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include "Password can't be blank"
    end
    it "is invalid if the password_confirmation attribute is omitted" do
      user = User.new(
        first_name: "Steve",
        last_name: "O",
        email: "steve0@gmail.com",
        password: "123456",
        password_confirmation: nil
      )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include "Password confirmation can't be blank"
    end
    it "must be created using a unique email address" do
      user = User.new(
        first_name: "test",
        last_name: "test",
        email: "test@test.com",
        password: "123456",
        password_confirmation: "123456"
      )
      user.save
      user2 = User.new(
        first_name: "test",
        last_name: "test",
        email: "test@test.com",
        password: "123456",
        password_confirmation: "123456"
      )
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to include "Email has already been taken"
    end
    it "must be created with a matching password and password_confirmation field " do
      user = User.new(
        first_name: "Tom",
        last_name: "Petty",
        email: "tom@gmail.com",
        password: "123456",
        password_confirmation: "654321"
      )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it "is invalid if password length is < 5" do
      user = User.new(
        first_name: "B.B.",
        last_name: "King",
        email: "saxman@gmail.com",
        password: "123",
        password_confirmation: "123"
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end
  end
  describe '.authenticate_with_credentials' do
    it "Should return the user if credentials are valid" do
      user = User.new(
        first_name: "Jimmy",
        last_name: "Paige",
        email: "JimP@gmail.com",
        password: "123456",
        password_confirmation: "123456")
      user.save
      authedUser = User.authenticate_with_credentials('JimP@gmail.com', '123456')
      expect(authedUser).to eq(user)
    end
    it "Should return nil if email address is not valid" do
      user = User.new(
        first_name: "Jimmy",
        last_name: "Paige",
        email: "JimP@gmail.com",
        password: "123456",
        password_confirmation: "123456")
      user.save
      authedUser = User.authenticate_with_credentials('JimmyPaige@gmail.com', '123456')
      expect(authedUser).to eq(nil)
    end
    it "Should return nil if password is not valid" do
      user = User.new(
        first_name: "Jimmy",
        last_name: "Paige",
        email: "JimP@gmail.com",
        password: "123456",
        password_confirmation: "123456")
      user.save
      authedUser = User.authenticate_with_credentials('JimP@gmail.com', '246810')
      expect(authedUser).to eq(nil)
    end
    it "Should return the user if credentials are valid and email is case-insensitive" do
      user = User.new(
        first_name: "Jimmy",
        last_name: "Paige",
        email: "JimP@gmail.com",
        password: "123456",
        password_confirmation: "123456")
      user.save
      authedUser = User.authenticate_with_credentials('JiMP@Gmail.com', '123456')
      expect(authedUser).to eq(user)
    end
    it "Should return the user if credentials are valid and email whitespace is stripped" do
      user = User.new(
        first_name: "Jimmy",
        last_name: "Paige",
        email: "JimP@gmail.com",
        password: "123456",
        password_confirmation: "123456")
      user.save
      authedUser = User.authenticate_with_credentials(' JimP@gmail.com  ', '123456')
      expect(authedUser).to eq(user)
    end
  end
end
