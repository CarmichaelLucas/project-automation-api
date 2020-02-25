module Gerar_Boleto
    include HTTParty

    base_uri 'https://api.intermediador.sandbox.yapay.com.br/api/v3/transactions/payment'
    format :json
    headers 'Content-Type': 'application/json'
end