# frozen_string_literal: true

RSpec.describe 'Gerar Boleto' do
  let(:transaction_product) { attributes_for(:transaction_product, price_unit: -150.0) }
  let(:payload) { attributes_for(:payload, transaction_product: transaction_product) }
  let(:response) { Boleto.new(payload).post }

    context 'Valor do produto negativo' do
      
      it { expect(response.code).to eq(422) }
      it { expect(response.parsed_response['message_response']['message']).to eq('error') } 

        # depende do valor negativo (pe.: R$ -130,00) informado apresenta a msg de retorno abaixo com o 
        # code = '17' junto ao code = '18', por isso a comparação com o IF.
        #if response.parsed_response['error_response']['validation_errors'].include? ["code" => "17"]
        #    expect(response.parsed_response['error_response']['validation_errors']).to match_array([
        #        "code" => "17", 
        #        "message" => "deve ser maior ou igual a 0", 
        #        "field" => "price_seller", 
        #        "message_complete" => "Valor loja deve ser maior do que 0"
        #    ])
        #end

        #if response.parsed_response['error_response']['validation_errors'].include? ["code" => "18"]
        #    expect(response.parsed_response['error_response']['validation_errors']).to match_array([
        #        "code" => "18", 
        #        "message" => "deve ser maior ou igual a 0", 
        #        "field" => "transaction_products.price_unit", 
        #        "message_complete" => "Valor Unitário deve ser maior ou igual a 0"
        #    ])
        #end

        #expect(response.parsed_response['additional_data']['transaction_id']).to be_falsey
        #expect(response.parsed_response['additional_data']['order_number']).to be_falsey
        #expect(response.parsed_response['additional_data']['status_id']).to be_falsey
        #expect(response.parsed_response['additional_data']['status_name']).to be_falsey
        #expect(response.parsed_response['additional_data']['token_transaction']).to be_falsey
    end
end