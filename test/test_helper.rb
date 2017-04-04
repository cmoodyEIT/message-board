ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/reporters'
require 'database_cleaner'
require 'ffaker'
require 'fabrication'
require 'setup_extension'
require 'integration_extension'

DatabaseCleaner.strategy = :transaction

Fabrication.configure do |config|
  config.path_prefix     = Rails.root
  config.fabricator_path = 'db/fabricators'
  config.sequence_start  = 10000
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
I18n.locale = I18n.default_locale
