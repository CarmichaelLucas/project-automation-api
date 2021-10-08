# frozen_string_literal: true

require_relative '../../models/transaction_product'

FactoryBot.define do
  factory :transaction_product do
    skip_create

    description   { Faker::Commerce.product_name }
    quantity      { rand(1..5) }
    price_unit    { Faker::Commerce.price }
    code          { Faker::Code.npi }
    sku_code      { Faker::Code.npi }
    extra         { Faker::Lorem.word }
  end
end
