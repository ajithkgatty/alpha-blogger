class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
	validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 5, maximum: 20}
	validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 5, maximum: 50}, format: { with: VALID_EMAIL_REGEX }
end
 