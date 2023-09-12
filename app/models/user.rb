class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_validation { email.downcase! }

  has_secure_password
  validates :password, length: { minimum: 4 }

  before_destroy do
    if self.admin && User.where(admin: true).count == 1
      throw :abort
    end
  end

  has_many :tasks, dependent: :destroy

end