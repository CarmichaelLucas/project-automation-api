require_relative '../../models/addresses'

FactoryBot.define do
  factory :addresses do
    skip_create

    type_address    { "B" }
    postal_code     { "17000-000" }
    street          { Faker::Address.street_name }
    number          { Faker::Address.building_number }
    completion      { "A" }
    neighborhood    { "Nova Marília" }
    city            { Faker::Address.city }
    state           { Faker::Address.state_abbr }
  end
end