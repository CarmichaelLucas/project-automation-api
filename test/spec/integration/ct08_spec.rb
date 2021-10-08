# frozen_string_literal: true

RSpec.describe 'Billet' do
  let(:transaction) do
    attributes_for(:transaction, available_payment_methods: '', customer_ip: '', shipping_type: '', shipping_price: '',
                                 url_notification: '', free: '')
  end
  let(:transaction_product) do
    attributes_for(:transaction_product, description: '', quantity: '', price_unit: '', code: '', sku_code: '',
                                         extra: '')
  end
  let(:customer) do
    attributes_for(:customer, name: '', cpf: '', birth_date: '', email: '', contacts: contacts, addresses: addresses)
  end
  let(:addresses) do
    attributes_for(:addresses, type_address: '', postal_code: '', street: '', number: '', completion: '',
                               neighborhood: '', city: '', state: '')
  end
  let(:contacts)            { attributes_for(:contacts, type_contact: '', number_contact: '') }
  let(:payment)             { attributes_for(:payment, payment_method_id: '') }
  let(:payload)             do
    attributes_for(:payload, token_account: '', customer: customer, transaction_product: transaction_product,
                             transaction: transaction, payment: payment)
  end
  let(:response) { Boleto.new(payload).post }
  let(:error_message) do
    [
      {
        'code' => '003039',
        'message' => 'Vendedor inválido ou não encontrado'
      }
    ]
  end

  it { expect(response.code).to eq(422) }
  it { expect(response['message_response']['message']).to eq('error') }
  it { expect(response.parsed_response['error_response']['general_errors']).to match_array(error_message) }
end
