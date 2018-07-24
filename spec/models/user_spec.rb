require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validations" do

    before :each do
      User.create!({
        password: "abc123",
        password_confirmation: "abc123",
        name: "User",
        email: "new@ME.com"
      })
    end

    it "should save when all fields filled out" do
      User.create!({
        password: "abc123",
        password_confirmation: "abc123",
        name: "User",
        email: "new@user.com"
      })
    end

    it "should fail when passwords don't match" do
      @user = User.create({
        password: "abc123",
        password_confirmation: "123abc",
        name: "User",
        email: "new@user.com"
      })
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should fail when password missing" do
      @user = User.create({
        password: nil,
        password_confirmation: "123abc",
        name: "User",
        email: "new@user.com"
      })
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should fail when name missing" do
      @user = User.create({
        password: "abc123",
        password_confirmation: "abc123",
        name: nil,
        email: "new@user.com"
      })
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "should fail when email missing" do
      @user = User.create({
        password: "abc123",
        password_confirmation: "abc123",
        name: "User",
        email: nil
      })
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "should fail when email exists" do
      @user = User.create({
        password: "abc123",
        password_confirmation: "abc123",
        name: "User",
        email: "NEW@me.com"
      })
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    it "should fail when password too short" do
      @user = User.create({
        password: "a",
        password_confirmation: "a",
        name: "User",
        email: "new@user.com"
      })
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end

  end

  describe '.authenticate_with_credentials' do

    before :each do
      @user = User.create!({
        password: "abc123",
        password_confirmation: "abc123",
        name: "User",
        email: "hello@123.com"
      })
    end

    it "should pass" do
      User.authenticate_with_credentials("     Hello@123.com", "abc123")
    end

    it "should fail due to incorrect email" do
      expect(User.authenticate_with_credentials("123@hello.com", "abc123")).to be_nil
    end

    it "should fail due to incorrect password" do
      expect(User.authenticate_with_credentials("hello@123.com", "abc1")).to be_nil
    end

  end

end
