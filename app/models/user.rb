class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :rooms, dependent:  :destroy 
  has_many :reservations, dependent:  :destroy  
  has_one_attached :avatar 

  validates :username, presence: true   

  def update_without_password(params)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params)
    clean_up_passwords
    result
  end
end
