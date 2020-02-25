# analista-yapay

Teste para Analistade QA

A empresa Pagamento S/A criou uma api de pagamento para facilitar a integração e para garantir que alterações na aplicação não gere falha nesta API, será necessário automatizar o teste a automação será realizada pelo time de QA (Quality Assurance), você sendo o Analista deste time deve: 

- Implementar o testes da api de pagamento utilizando a forma de pagamento “Boleto”, utilize o documento abaixo para maiores informações sobre a API: ( https://intermediador.dev.yapay.com.br/#/transacao-boleto ) - Implementar massa de dados onde, possua seguintes cenários : 
* Cenário 1: Todos os dados válidos 
* Cenário 2: E-mail inválido 
* Cenário 3: CPF Inválido 
* Cenário 4: Valor do produto igual a 0 
* Cenário 5: Valor do produto negativo 
* Cenário 6: ID da forma de pagamento inválida 
* Cenário 7: Dados sem o nó de pagamento 
* Cenário 8: Todos os dados em branco 

- Validações a serem aplicadas no retorno 
* Http Status Code 
* Retorno da URL do boleto, linha digitável e tid 
* Dados do cliente são iguais ao enviado 
* Valor informado é o mesmo retornado 
* Validação dos erros retornados quando houver 

>> Author: Lucas Carmichael