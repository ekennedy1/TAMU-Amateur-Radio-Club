class User < ApplicationRecord
  # Including default modules provided by Devise for authentication.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: { member: 0, admin: 1 }

  # Validating presence of first name and last name for each user.
  validates :fname, :lname, presence: true

  # Create or find a user based on Google's OAuth2 response.
  def self.from_google(email:, full_name:, uid:)
    # Only allow emails from gmail.com or tamu.edu domains for registration.
    return nil unless email =~ /@gmail.com\z/ || email =~ /@tamu.edu\z/

    names = full_name.split
    first_name = names.first
    last_name = names.last

    # Generate a random password for OAuth users
    password = Devise.friendly_token[0, 20]

    # Use the split names in your creation logic.
    create_with(uid: uid, fname: first_name, lname: last_name, email: email, password: password, role: :member).find_or_create_by!(email: email)
  end
end
