describe 'Gerar Boleto:' do
    before(:each) do
        @name = "Stephen Strange"
        @cpf = "35502074846"
        @token = "INSIRA SEU TOKEN"
    end

    it 'Valor do produto negativo' do
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
                "price_unit":"-10.00",
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
        
        @resp = Gerar_Boleto.post('/', body: @body)

        #codigo retorno
        expect(@resp.code).to eq 422
        expect(@resp.parsed_response['message_response']['message']).to eq("error") 

        #validando o array 

        # depende do valor negativo (pe.: R$ -130,00) informado apresenta a msg de retorno abaixo com o 
        # code = '17' junto ao code = '18', por isso a comparação com o IF.
        #if @resp.parsed_response['error_response']['validation_errors'].include? ["code" => "17"]
        #    expect(@resp.parsed_response['error_response']['validation_errors']).to match_array([
        #        "code" => "17", 
        #        "message" => "deve ser maior ou igual a 0", 
        #        "field" => "price_seller", 
        #        "message_complete" => "Valor loja deve ser maior do que 0"
        #    ])
        #end

        if @resp.parsed_response['error_response']['validation_errors'].include? ["code" => "18"]
            expect(@resp.parsed_response['error_response']['validation_errors']).to match_array([
                "code" => "18", 
                "message" => "deve ser maior ou igual a 0", 
                "field" => "transaction_products.price_unit", 
                "message_complete" => "Valor Unitário deve ser maior ou igual a 0"
            ])
        end

        expect(@resp.parsed_response['additional_data']['transaction_id']).to be_falsey
        expect(@resp.parsed_response['additional_data']['order_number']).to be_falsey
        expect(@resp.parsed_response['additional_data']['status_id']).to be_falsey
        expect(@resp.parsed_response['additional_data']['status_name']).to be_falsey
        expect(@resp.parsed_response['additional_data']['token_transaction']).to be_falsey
    end
end