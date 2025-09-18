*** Settings ***
Documentation     Testes para a API Restful-Booker.
Resource          ../resources/api_keywords.robot
Resource          ../resources/variables/common.robot

Suite Setup       Criar Sessão API    ${BOOKER_URL}
Suite Teardown    Delete All Sessions

*** Test Cases ***
Criar Token
    [Tags]    smoke    auth
    &{data}=    Criar Dicionário    username    ${USERNAME}    password    ${PASSWORD}
    ${resp}=    Realizar Requisição POST    /auth    ${data}
    Verificar Status Code    ${resp}    200
    ${token}=    Set Variable    ${resp.json()["token"]}
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

Criar Reserva
    [Tags]    smoke    regression
    &{booking}=    Criar Dicionário    firstname    Gabriel    lastname    Tester    totalprice    100    depositpaid    True    additionalneeds    Breakfast
    &{dates}=      Criar Dicionário    checkin    2025-09-04    checkout    2025-09-10
    &{booking}=    Adicionar Item ao Dicionário    ${booking}    bookingdates    ${dates}
    ${resp}=    Realizar Requisição POST    /booking    ${booking}
    Verificar Status Code    ${resp}    200
    ${BOOKING_ID}=    Set Variable    ${resp.json()["bookingid"]}
    Set Suite Variable    ${BOOKING_ID}

Editar Reserva
    [Tags]    regression
    &{headers}=    Criar Dicionário    Cookie    token=${AUTH_TOKEN}
    &{update}=    Criar Dicionário    firstname    Gabriel    lastname    Atualizado    totalprice    200    depositpaid    False
    &{dates}=      Criar Dicionário    checkin    2025-09-05    checkout    2025-09-12
    &{update}=    Adicionar Item ao Dicionário    ${update}    bookingdates    ${dates}
    ${resp}=    Realizar Requisição PUT    /booking/${BOOKING_ID}    ${update}    ${headers}
    Verificar Status Code    ${resp}    200
    Verificar JSON Contém    ${resp}    lastname    Atualizado

Excluir Reserva
    [Tags]    regression
    &{headers}=    Criar Dicionário    Cookie    token=${AUTH_TOKEN}
    ${resp}=    Realizar Requisição DELETE    /booking/${BOOKING_ID}    ${headers}
    Verificar Status Code    ${resp}    201
