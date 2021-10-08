# frozen_string_literal: true

require_relative '../../models/contacts'

FactoryBot.define do
  factory :contacts do
    skip_create

    type_contact    { 'H' }
    number_contact  { '14988773322' }
  end
end
