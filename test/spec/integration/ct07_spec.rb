# frozen_string_literal: true

RSpec.describe 'Gerar Boleto' do
  let(:payload) do
     payload = attributes_for(:payload)
     payload.delete(:payment)
     payload
  end
  let(:response) { Boleto.new(payload).post }

  context 'Dados sem o nó de pagamento' do

    it { expect(response.code).to eq(422) }
    it { expect(response['message_response']['message']).to eq("error") }
    
    it { 
      expect(response.parsed_response['error_response']['general_errors']).to match_array([
                                                                                            "code" => "003010",
                                                                                            "message" => "Forma de pagamento inválida"
                                                                                          ])
    }

    it { expect(response.parsed_response['additional_data']['transaction_id']).to be_truthy }
    it { expect(response.parsed_response['additional_data']['order_number']).not_to be_empty } 
    it { expect(response.parsed_response['additional_data']['status_id']).to eq(4) }
    it { expect(response.parsed_response['additional_data']['status_name']).to eq("Aguardando Pagamento") }
    it { expect(response.parsed_response['additional_data']['token_transaction']).not_to be_empty } 
  end
end