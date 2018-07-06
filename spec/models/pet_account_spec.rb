require 'rails_helper'

describe 'PetAccount Model' do
  before(:each) do
    set_variables
  end

  it 'contains a user_id and a dog_id' do
    expect(@buck_account).to be_valid
  end

  it 'must contain a user_id and a dog_id' do
    no_dog = PetAccount.new(:user_id => @lightning.id)
    no_user = PetAccount.new(:dog_id => @buck.id)

    expect(no_dog).to be_invalid
    expect(no_user).to be_invalid
  end
end 
