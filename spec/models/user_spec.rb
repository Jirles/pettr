require 'rails_helper'

describe 'User Model' do
  before(:each) do
    set_variables
  end

  it 'has attributes first_name, last_name, email, and password' do
    expect(@linda).to be_valid
  end

  it 'requires an email to be present and unique' do
    no_email = User.create(:first_name => "Emily", :last_name => "Jirles", :password => 'secret')
    copy_cat = User.create(:first_name => "Jack", :last_name => "Quest", :email => 'jquest@cartoons.com', :password => 'fail')
    expect(no_email).to be_invalid
    expect(copy_cat).to be_invalid
  end

  it 'has many dogs through pettings' do
    expect(@linda.pettings.size).to eq(2)
    expect(@linda.dogs).to include(@buck)
  end

  it 'has a full_name method that returns a users full name' do
    expect(@lightning.full_name).to eq("Lightning McQueen")
  end

  it 'has a find_by_or_create_from_auth_hash class method that will create a new user using info from Facebook' do
    auth_create = {'info': {'email': 'example@test.com', 'name': 'Jane Doe', 'uid': '12345'}}
    user = User.find_by_or_create_from_auth_hash(auth_create)

    expect(user.full_name).to eq('Jane Doe')
    expect(user.email).to eq('example@test.com')
    expect(user.authenticate('12345')).to be_truthy
  end

  it 'has a find_by_or_create_from_auth_hash class method that will find an existing user using info from Facebook' do
    auth_find = {'info': {'email': 'jquest@cartoons.com', 'name': 'Johnny Quest', 'uid': '88719874829283'}}

    user = User.find_by_or_create_from_auth_hash(auth_find)
    expect(user).to eq(@jquest)
  end

  it 'returns nil if the email attribute isnt present' do
    auth_no_email = {'info': {'name': 'Johnny Quest', 'uid': '88719874829283'}}

    user = User.find_by_or_create_from_auth_hash(auth_no_email)
    expect(user).to be_nil
  end

end
