module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = User.find_or_create_by(email: 'admin@test.com', admin: true)
      sign_in admin
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.find_or_create_by(email: 'user@test.com')
      sign_in user
    end
  end
end
