# SDK Ruby Braspag

## Principais recursos

* [x] Pagamentos por cartão de crédito.
* [x] Pagamentos recorrentes.
    * [x] Com autorização na primeira recorrência.
    * [x] Com autorização a partir da primeira recorrência.
* [x] Pagamentos por cartão de débito.
* [x] Pagamentos por boleto.
* [x] Pagamentos por transferência eletrônica.
* [x] Cancelamento de autorização.
* [x] Consulta de pagamentos.

## Limitações

Por envolver a interface de usuário da aplicação, o SDK funciona apenas como um framework para criação das transações. Nos casos onde a autorização é direta, não há limitação; mas nos casos onde é necessário a autenticação ou qualquer tipo de redirecionamento do usuário, o desenvolvedor deverá utilizar o SDK para gerar o pagamento e, com o link retornado pela Braspag, providenciar o redirecionamento do usuário.

## Instalação

`gem install braspag-api`

## Utilizando o SDK

Para criar um pagamento simples com cartão de crédito com o SDK, basta fazer:

### Criando um pagamento com cartão de crédito

```ruby
require "braspag/api"

# Configure seu merchant
merchant = Braspag::Merchant.new("MERCHANT-ID", "MERCHANT-KEY")

# Crie uma instância de Sale informando o ID do pagamento
sale = Braspag::Sale.new("123")

# Crie uma instância de Customer informando o nome do cliente
sale.customer = Braspag::Customer.new("Fulano de Tal")

# Crie uma instância de Payment informando o valor do pagamento
sale.payment = Braspag::Payment.new(15700)

# Informe o Provider e o tipo de pagamento que será utilizado
sale.payment.provider = Braspag::Payment::PROVIDER_SIMULADO
sale.payment.type = Braspag::Payment::PAYMENTTYPE_CREDITCARD

# Crie  uma instância de Credit Card utilizando os dados de teste
sale.payment.credit_card = Braspag::CreditCard.new(security_code: "123", brand: "Visa")
sale.payment.credit_card.expiration_date = "12/2018"
sale.payment.credit_card.holder = "Fulano de Tal"
sale.payment.credit_card.card_number = "0000000000000001"

# Configure o SDK com seu merchant e o ambiente apropriado para criar a venda
braspag_api = Braspag::API.new(merchant, Braspag::Environment::sandbox)

# Crie a venda na Braspag
sale = braspag_api.create_sale(sale)

# Com a venda criada na Braspag, já temos o ID do pagamento, TID e demais
# dados retornados pela Braspag
payment_id = sale.payment.payment_id

# Com o ID do pagamento, podemos fazer sua captura, se ela não tiver sido capturada ainda
braspag_api.capture_sale(payment_id)

# E também podemos fazer seu cancelamento, se for o caso
braspag_api.cancel_sale(payment_id)
