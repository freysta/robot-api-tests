*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Criar Sessão API
    [Arguments]    ${base_url}
    Create Session    api    ${base_url}

Realizar Requisição GET
    [Arguments]    ${endpoint}
    ${response}=    GET On Session    api    ${endpoint}
    RETURN    ${response}

Realizar Requisição POST
    [Arguments]    ${endpoint}    ${payload}
    ${response}=    POST On Session    api    ${endpoint}    json=${payload}
    RETURN    ${response}

Realizar Requisição PUT
    [Arguments]    ${endpoint}    ${payload}    ${headers}=${None}
    ${response}=    PUT On Session    api    ${endpoint}    json=${payload}    headers=${headers}
    RETURN    ${response}

Realizar Requisição DELETE
    [Arguments]    ${endpoint}    ${headers}=${None}
    ${response}=    DELETE On Session    api    ${endpoint}    headers=${headers}
    RETURN    ${response}

Validar Status Code
    [Arguments]    ${response}    ${codigo_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${codigo_esperado}

Validar Campo JSON
    [Arguments]    ${response}    ${campo}    ${valor_esperado}
    Dictionary Should Contain Item    ${response.json()}    ${campo}    ${valor_esperado}

Criar Headers Autenticacao
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Cookie    token=${token}
    RETURN    ${headers}

Criar Dados Reserva
    [Arguments]    ${nome}    ${sobrenome}    ${preco_total}    ${deposito_pago}    ${checkin}    ${checkout}    ${extras}=${EMPTY}
    &{datas_reserva}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    &{dados_reserva}=    Create Dictionary    
    ...    firstname=${nome}
    ...    lastname=${sobrenome}
    ...    totalprice=${preco_total}
    ...    depositpaid=${deposito_pago}
    ...    bookingdates=${datas_reserva}
    Run Keyword If    '${extras}' != '${EMPTY}'    Set To Dictionary    ${dados_reserva}    additionalneeds=${extras}
    RETURN    ${dados_reserva}

Criar Credenciais Login
    [Arguments]    ${usuario}    ${senha}
    &{credenciais}=    Create Dictionary    username=${usuario}    password=${senha}
    RETURN    ${credenciais}

Executar Requisicao Com Validacao
    [Arguments]    ${metodo}    ${endpoint}    ${codigo_esperado}    ${payload}=${None}    ${headers}=${None}
    ${response}=    Run Keyword    Realizar Requisição ${metodo}    ${endpoint}    ${payload}    ${headers}
    Validar Status Code    ${response}    ${codigo_esperado}
    RETURN    ${response}

# Keywords de Alto Nível para Operações de Negócio
Obter Token Autenticacao
    [Documentation]    Autentica usuário e armazena token
    ${credenciais}=    Criar Credenciais Login    ${USERNAME}    ${PASSWORD}
    ${response}=    Executar Requisicao Com Validacao    POST    /auth    ${STATUS_OK}    ${credenciais}
    ${token}=    Set Variable    ${response.json()["token"]}
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

Criar Reserva Padrao
    [Documentation]    Cria reserva com dados padrão
    ${dados}=    Criar Dados Reserva    ${NOME_PADRAO}    ${SOBRENOME_PADRAO}    ${PRECO_PADRAO}    True    ${DATA_CHECKIN}    ${DATA_CHECKOUT}    ${EXTRAS_PADRAO}
    ${response}=    Executar Requisicao Com Validacao    POST    /booking    ${STATUS_OK}    ${dados}
    ${id}=    Set Variable    ${response.json()["bookingid"]}
    Set Suite Variable    ${BOOKING_ID}    ${id}

Atualizar Reserva
    [Arguments]    &{campos}
    [Documentation]    Atualiza reserva existente com campos específicos
    ${headers}=    Criar Headers Autenticacao    ${AUTH_TOKEN}
    ${dados}=    Criar Dados Reserva    ${NOME_PADRAO}    ${SOBRENOME_PADRAO}    ${PRECO_PADRAO}    True    2025-09-05    2025-09-12
    FOR    ${campo}    ${valor}    IN    &{campos}
        Set To Dictionary    ${dados}    ${campo}    ${valor}
    END
    ${response}=    Executar Requisicao Com Validacao    PUT    /booking/${BOOKING_ID}    ${STATUS_OK}    ${dados}    ${headers}
    Run Keyword If    'lastname' in ${campos}    Validar Campo JSON    ${response}    lastname    ${campos}[lastname]

Excluir Reserva
    [Documentation]    Remove reserva do sistema
    ${headers}=    Criar Headers Autenticacao    ${AUTH_TOKEN}
    Executar Requisicao Com Validacao    DELETE    /booking/${BOOKING_ID}    ${STATUS_CREATED}    headers=${headers}
