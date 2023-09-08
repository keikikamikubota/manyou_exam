class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password
end
