*** Variables ***
# URLs da API
${BOOKER_URL}           https://restful-booker.herokuapp.com

# Credenciais de Autenticação
${USERNAME}             admin
${PASSWORD}             password123

# Dados Padrão para Testes
${NOME_PADRAO}          Gabriel
${SOBRENOME_PADRAO}     Tester
${PRECO_PADRAO}         100
${DATA_CHECKIN}         2025-09-04
${DATA_CHECKOUT}        2025-09-10
${EXTRAS_PADRAO}        Breakfast

# Status Codes Esperados
${STATUS_OK}            200
${STATUS_CREATED}       201
${STATUS_NO_CONTENT}    204
