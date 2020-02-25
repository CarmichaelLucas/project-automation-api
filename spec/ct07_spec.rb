describe 'Gerar Boleto:' do
    before(:each) do
        @nome = "Stephen Strange"
        @cpf = "35502074846"
        @token = "INSIRA SEU TOKEN"
    end

    it 'Dados sem o nó de pagamento' do
        @body = {  
            "token_account": @token,
            "customer":{  
              "contacts":[  
                {  
                  "type_contact":"H",
                  "number_contact":"1133221122"
                },
                {  
                  "type_contact":"M",
                  "number_contact":"11999999999"
                }
              ],
              "addresses":[  
                {  
                  "type_address":"B",
                  "postal_code":"17000-000",
                  "street":"Av Esmeralda",
                  "number":"1001",
                  "completion":"A",
                  "neighborhood":"Jd Esmeralda",
                  "city":"Marilia",
                  "state":"SP"
                }
              ],
              "name": @name,
              "birth_date":"21/05/1941",
              "cpf": @cpf,
              "email":"stephen.strange@avengers.com"
            },
            "transaction_product":[  
              {  
                "description":"Camiseta Tony Stark",
                "quantity":"1",
                "price_unit":"130.00",
                "code":"1",
                "sku_code":"0001",
                "extra":"Informação Extra"
              }
            ],
            "transaction":{  
              "available_payment_methods":"2,3,4,5,6,7,14,15,16,18,19,21,22,23",
              "customer_ip":"127.0.0.1",
              "shipping_type":"Sedex",
              "shipping_price":"12",
              "price_discount":"",
              "url_notification":"http://www.loja.com.br/notificacao",
              "free":"Campo Livre"
            }
        }.to_json
        
        @resp = Gerar_Boleto.post('/', body: @body)

        expect(@resp.code).to eq(422)
        expect(@resp['message_response']['message']).to eq("error")
        
        expect(@resp.parsed_response['error_response']['general_errors']).to match_array([
            "code" => "003010",
            "message" => "Forma de pagamento inválida"
        ])

        expect(@resp.parsed_response['additional_data']['transaction_id']).to be_truthy
        expect(@resp.parsed_response['additional_data']['transaction_id'].size).to be > 0
        expect(@resp.parsed_response['additional_data']['order_number']).not_to be_empty 
        expect(@resp.parsed_response['additional_data']['order_number'].size).to be > 0
        expect(@resp.parsed_response['additional_data']['status_id']).to eq(4)
        expect(@resp.parsed_response['additional_data']['status_name']).to eq("Aguardando Pagamento")
        expect(@resp.parsed_response['additional_data']['token_transaction']).not_to be_empty 
        expect(@resp.parsed_response['additional_data']['token_transaction'].size).to be > 0
    end
end