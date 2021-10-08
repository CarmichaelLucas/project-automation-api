# frozen_string_literal: true

require_relative '../../models/payload'

FactoryBot.define do
  factory :payload do
    skip_create

    token_account       { ENV['TOKEN_API_YAPAY'] }
    customer            { attributes_for(:customer) }
    transaction_product { attributes_for_list(:transaction_product, 1) }
    transaction         { attributes_for(:transaction) }
    payment             { attributes_for(:payment) }
  end
end
