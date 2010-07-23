# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bcms_pubcookie_session',
  :secret      => '6dce1dc0b769e57ddd36fbfdd48f258d98d12361bebcbdfd342ea60c84330fa336d5f0a1a53827f0688e9ab451d2c10eae7327fad0720461d263b93e9746c813'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
