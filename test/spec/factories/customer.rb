# frozen_string_literal: true

require_relative '../../models/customer'

FactoryBot.define do
  factory :customer do
    skip_create

    name          { Faker::Name.name }
    cpf           { Faker::IDNumber.brazilian_citizen_number }
    birth_date    { Faker::Date.in_date_period(year: 1990).strftime('%d/%m/%Y') }
    email         { Faker::Internet.email(domain: 'yapay') }
    contacts      { attributes_for_list(:contacts, 2) }
    addresses     { attributes_for_list(:addresses, 1) }
  end
end
