class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :password, confirmation: { case_sensitive: true }
  
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end
  
  def self.authenticate_with_credentials(email, password)
    user = find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end 

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
