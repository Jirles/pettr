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

end
