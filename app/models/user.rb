class User < ApplicationRecord
  has_secure_password

  validates :name,
            presence: true,
            uniqueness: { message: "はすでに登録されています" },
            length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
end
