# frozen_string_literal: true

# This controller handles authentication callbacks from omniauth providers,
# specifically the Google OAuth2 callback in this case.
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # This method gets called when a user tries to authenticate using Google OAuth2.
  def google_oauth2
    # Get or create the user from the Google OAuth2 data.
    user = User.from_google(**from_google_params)
    # Check if the user is present and valid.
    if user.present?
      # Sign out of any other sessions to ensure user is signing in with the recent Google account.
      sign_out_all_scopes
      # Set a success message for the user.
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      # Sign in the user and redirect them to the destination or root path.
      sign_in_and_redirect user, event: :authentication
    else
      # If the user isn't found, set an error message.
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      # Redirect to the sign-in page.
      redirect_to new_user_session_path
    end
  end

  protected

  # Define the path users will be redirected to if there's a failure in omniauth.
  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  # Define the path users will be redirected to after they sign in.
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  # Extract parameters from the Google OAuth2 data to be used for user creation.
  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      # TODO: CHANGE LATER TO SPLIT FIRST AND LAST NAME
      full_name: auth.info.name,
    }
  end

  # Get the Google OAuth2 data from the request.
  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
