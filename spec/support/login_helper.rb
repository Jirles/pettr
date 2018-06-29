module LoginHelper

  def create_gene_belcher
    User.create(first_name: "Gene", last_name: "Belcher", email: "keyboard@bobsburgers.com", password: "farts")
  end

  def create_louise_belcher
    User.create(first_name: "Louise", last_name: "Belcher", email: "lb@burgers.com", password: 'secret')
  end

  def signup_as_bob_belcher
    visit signup_path
    fill_in(:user_first_name, with: "Bob")
    fill_in(:user_last_name, with: "Belcher")
    fill_in(:user_email, with: "bob@burgers.com")
    fill_in(:user_password, with: "burgers")
    click_button "SignUp"
  end
  
  def login_as_louise
    visit login_path
    fill_in(:session_email, with: 'lb@burgers.com')
    fill_in(:session_password, with: 'secret')
    click_button "LogIn"
  end

end
