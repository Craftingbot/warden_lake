class SessionStrategy < ::Warden::Strategies::Base

  def valid?
    identity && password
  end

  def auth_class
    User
  end

  def authenticate!
    user = auth_class.find_by_login(params[:identity])
    if user && user.authenticate(password)
      success!(user)
    else
      fail!('strategies.authentication_token.failed')
    end
  end

  private
  def password
    sign_in_params['password']
  end

  def identity
    sign_in_params['identity']
  end


  def sign_in_params
    params['sign_in']
  end
end
