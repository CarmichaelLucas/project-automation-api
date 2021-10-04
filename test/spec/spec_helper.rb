require 'httparty'
require 'httparty/request'
require 'httparty/response/headers'
require 'faker'
require 'byebug'
require 'factory_bot'

# Helpers
require_relative 'helpers/boleto_helper'

# Factories
require_relative 'factories/addresses'
require_relative 'factories/contacts'
require_relative 'factories/customer'
require_relative 'factories/payload'
require_relative 'factories/payment'
require_relative 'factories/transaction_product'
require_relative 'factories/transaction'

RSpec.configure do |config|
  
  # Boleto Helper
  include API

  # rubocop-rspec
  config.alias_example_group_to :detail, :detailed => true

  # factory_bot
  config.include FactoryBot::Syntax::Methods


end
