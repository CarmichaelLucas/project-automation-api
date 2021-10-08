# frozen_string_literal: true

require_relative '../../models/transaction'

FactoryBot.define do
  factory :transaction do
    skip_create

    available_payment_methods   { '2,3,4,5,6,7,14,15,16,18,19,21,22,23' }
    customer_ip                 { Faker::Internet.ip_v4_address }
    shipping_type               { 'Sedex' }
    shipping_price              { '12' }
    price_discount              { nil }
    url_notification            { Faker::Internet.url(host: 'lojinha.com') }
    free                        { Faker::Lorem.word }
  end
end
