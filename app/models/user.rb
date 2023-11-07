class User < ApplicationRecord
  # Including default modules provided by Devise for authentication.
  # Other available modules include :confirmable, :lockable, :timeoutable, and :trackable.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Validating presence of first name, last name, and role for each user.
  validates :fname, :lname, :role, presence: true

  # Check if the user has the role 'Admin'.
  def admin?
    role == 'Admin'
  end

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
    create_with(uid: uid, fname: first_name, lname: last_name, email: email, password: password, role: 'Member').find_or_create_by!(email: email)
  end
end
