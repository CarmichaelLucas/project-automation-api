# frozen_string_literal: true

RSpec.describe 'Gerar Boleto' do
  let(:customer)  { attributes_for(:customer, email: 'invalid.email.com') }
  let(:payload)   { attributes_for(:payload, customer: customer) }
  let(:response)  { Boleto.new(payload).post }

  context 'Email Invalido' do
    it { expect(response.code).to eq(422) }
    it { expect(response.parsed_response['message_response']['message']).to eq('error') }

    it {
      expect(response.parsed_response['error_response']['validation_errors']).to match_array([
                                                                                               'code' => '3',
                                                                                               'message' => 'não é válido',
                                                                                               'field' => 'email',
                                                                                               'message_complete' => 'E-mail não é válido'
                                                                                             ])
    }
  end
end
