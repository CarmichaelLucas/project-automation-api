describe 'Gerar Boleto:' do
    before(:each) do
        @nome = ""
        @cpf = ""
        @token = ""
    end

    it 'Todos os dados em branco' do
        @body = {  
            "token_account": @token,
            "customer":{  
              "contacts":[  
                {  
                  "type_contact":"",
                  "number_contact":""
                },
                {  
                  "type_contact":"",
                  "number_contact":""
                }
              ],
              "addresses":[  
                {  
                  "type_address":"",
                  "postal_code":"",
                  "street":"",
                  "number":"",
                  "completion":"",
                  "neighborhood":"",
                  "city":"",
                  "state":""
                }
              ],
              "name": @name,
              "birth_date":"",
              "cpf": @cpf,
              "email":""
            },
            "transaction_product":[  
              {  
                "description":"",
                "quantity":"",
                "price_unit":"",
                "code":"",
                "sku_code":"",
                "extra":""
              }
            ],
            "transaction":{  
              "available_payment_methods":"",
              "customer_ip":"",
              "shipping_type":"",
              "shipping_price":"",
              "price_discount":"",
              "url_notification":"",
              "free":""
            },
            "payment":{  
              "payment_method_id":""
            }
        }.to_json

        @resp = Gerar_Boleto.post('/', body: @body)

        expect(@resp.code).to eq(422)
        expect(@resp['message_response']['message']).to eq("error")
        
        expect(@resp.parsed_response['error_response']['general_errors']).to match_array([
            "code" => "003039",
            "message" => "Vendedor inválido ou não encontrado"
        ])

        expect(@resp.parsed_response['additional_data']['transaction_id']).to be_falsey
        expect(@resp.parsed_response['additional_data']['order_number']).to be_falsey
        expect(@resp.parsed_response['additional_data']['status_id']).to be_falsey
        expect(@resp.parsed_response['additional_data']['status_name']).to be_falsey
        expect(@resp.parsed_response['additional_data']['token_transaction']).to be_falsey

    end
end