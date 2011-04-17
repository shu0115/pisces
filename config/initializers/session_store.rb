# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pisces_session',
  :secret      => 'be2f90593e4b0a280badd9e71705ac8a065eb9e296072e3a64a4005510628bc3e3f9ad2d2391f83384db185972831a7e058866586f9f477443ec90056eb932dc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
