*** Settings ***
Documentation     Testes para a API Restful-Booker.
Resource          ../resources/api_keywords.robot
Resource          ../resources/variables/common.robot

Suite Setup       Criar Sessão API    ${BOOKER_URL}
Suite Teardown    Delete All Sessions

*** Test Cases ***
Autenticar Usuario
    [Tags]    smoke    auth
    [Documentation]    Realiza autenticação e obtém token de acesso
    Obter Token Autenticacao

Criar Nova Reserva
    [Tags]    smoke    regression
    [Documentation]    Cria uma nova reserva de hotel
    Criar Reserva Padrao

Atualizar Reserva Existente
    [Tags]    regression
    [Documentation]    Atualiza dados de uma reserva existente
    Atualizar Reserva    sobrenome=Atualizado    preco_total=200    deposito_pago=False

Remover Reserva
    [Tags]    regression
    [Documentation]    Remove uma reserva do sistema
    Excluir Reserva
