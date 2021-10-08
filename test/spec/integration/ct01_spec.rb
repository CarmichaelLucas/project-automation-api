# frozen_string_literal: true

RSpec.describe 'Billet' do
  let(:payload)         { attributes_for(:payload) }
  let(:price_payment)   do
    price_unit = payload[:transaction_product].first[:price_unit]
    quantity   = payload[:transaction_product].first[:quantity]
    shipping_price = payload[:transaction][:shipping_price].to_f

    price = (price_unit * quantity) + shipping_price
    price.round(2)
  end
  let(:response)   { Boleto.new(payload).post }
  let(:json)       { response.parsed_response['data_response']['transaction'] }

  it { expect(response.code).to eq 201 }
  it { expect(json['payment']['url_payment']).not_to be_empty }
  it { expect(json['payment']['tid']).not_to be_empty }

  it {
    expect(json['payment']['linha_digitavel']).not_to be_empty
  }

  it {
    expect(json['payment']['price_payment'].to_f).to eq(price_payment)
  }

  it {
    expect(json['payment']['price_original'].to_f).to eq(price_payment)
  }

  it { expect(json['customer']['name']).to eq(payload[:customer][:name]) }
  it { expect(json['customer']['cpf']).to eq(payload[:customer][:cpf]) }
end
