# frozen_string_literal: true

RSpec.describe 'Gerar Boleto' do
  let(:customer)  { attributes_for(:customer, cpf: '11111111111')}
  let(:payload)   { attributes_for(:payload, customer: customer) }
  let(:response)  { Boleto.new(payload).post } 

  context 'Com CPF invalido' do
      
    it { expect(response.code).to eq(422) }
    it { expect(response.parsed_response['message_response']['message']).to eq("error") } 
    it { 
      expect(response.parsed_response['error_response']['validation_errors']).to match_array([
                                                                                              "code" => "3", 
                                                                                              "message" => "não é válido", 
                                                                                              "field" => "cpf", 
                                                                                              "message_complete" => "CPF não é válido"
                                                                                          ]) 
    }
  end
end