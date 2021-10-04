# frozen_string_literal: true

RSpec.describe 'Gerar Boleto' do
  let(:payload)         { attributes_for(:payload) }
  let(:shipping_price)  { payload[:transaction][:shipping_price].to_f }
  let(:price_unit)      { payload[:transaction_product].first[:price_unit] }
  let(:quantity)        { payload[:transaction_product].first[:quantity] }
  let(:price_product)   { price_unit * quantity }
  let(:price_payment)   { price_product + shipping_price }
  let(:name)            { payload[:customer][:name] }
  let(:cpf)             { payload[:customer][:cpf] }
  let(:response)        { Boleto.new(payload).post }

  describe 'Dados validos para compra' do

    it { expect(response.code).to eq 201 }

    context 'Url Payment preenchida' do
      it { expect(response.parsed_response['data_response']['transaction']['payment']['url_payment']).not_to be_empty }
    end

    context 'TID preenchido' do
      it { expect(response.parsed_response['data_response']['transaction']['payment']['tid']).not_to be_empty }
    end

    context 'Linha digitavel preenchida' do
      it { expect(response.parsed_response['data_response']['transaction']['payment']['linha_digitavel']).not_to be_empty }
    end

    context 'Price payment e original somado corretamente' do
      it {
        expect(response.parsed_response['data_response']['transaction']['payment']['price_payment'].to_f).to eq(price_payment.round(2))
      }

      it {
        expect(response.parsed_response['data_response']['transaction']['payment']['price_original'].to_f).to eq(price_payment.round(2))
      }
    end

    context 'Dados do Customer corretos' do
      it { expect(response.parsed_response['data_response']['transaction']['customer']['name']).to eq(name) }
      it { expect(response.parsed_response['data_response']['transaction']['customer']['cpf']).to eq(cpf) }
    end
  end
end
