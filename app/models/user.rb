class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :login, :email, :password, :password_confirmation, :remember_me

  has_one :cart
	has_many :orders
	has_many :comments
end
