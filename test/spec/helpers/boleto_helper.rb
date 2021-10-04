module API

  class Boleto
    include HTTParty

    base_uri 'https://api.intermediador.sandbox.yapay.com.br'
    format :json

    def initialize(payload)
      @options = { body: payload }
    end

    def post
      self.class.post('/api/v3/transactions/payment', @options)
    end
  end
end