class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validation  # virtual attribute to skip password validation

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
