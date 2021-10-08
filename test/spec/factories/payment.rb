# frozen_string_literal: true

require_relative '../../models/payment'

FactoryBot.define do
  factory :payment do
    skip_create

    payment_method_id { '6' }
  end
end
