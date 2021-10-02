describe 'Gerar Boleto: ' do
    before(:each) do
        @name = "Stephen Strange"
        @cpf = "35502074846"
        @token = "INSIRA SEU TOKEN"
    end

    it 'Valor do produto igual a 0' do
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
                "price_unit":"0.00",
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
            },
            "payment":{  
                "payment_method_id":"6"
            }
        }.to_json
        @vlr_prod = 0.00 + 12
        @resp = Gerar_Boleto.post('/', body: @body)

        #validação Status de retorno
        expect(@resp.code).to eq 201
        expect(@resp.parsed_response['message_response']['message']).to eq 'success'

        #Informações Boleto
        expect(@resp.parsed_response['data_response']['transaction']['payment']['url_payment']).not_to be_empty 
        expect(@resp.parsed_response['data_response']['transaction']['payment']['url_payment'].size).to be > 0 

        expect(@resp.parsed_response['data_response']['transaction']['payment']['tid']).not_to be_empty
        expect(@resp.parsed_response['data_response']['transaction']['payment']['tid'].size).to be > 0
        
        expect(@resp.parsed_response['data_response']['transaction']['payment']['linha_digitavel']).not_to be_empty
        expect(@resp.parsed_response['data_response']['transaction']['payment']['linha_digitavel'].size).to be > 0

        expect(@resp.parsed_response['data_response']['transaction']['payment']['price_payment']).to be == @vlr_prod.to_s
        expect(@resp.parsed_response['data_response']['transaction']['payment']['price_original']).to be == @vlr_prod.to_s

        #Dados Cliente
        expect(@resp.parsed_response['data_response']['transaction']['customer']['name']).to eq @name
        expect(@resp.parsed_response['data_response']['transaction']['customer']['cpf']).to eq @cpf
    end
end