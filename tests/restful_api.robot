*** Settings ***
Library    RequestsLibrary
Resource   ../variables/common.robot

*** Test Cases ***
Criar Token
    Create Session    api    ${BOOKER_URL}
    &{data}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${resp}=    POST On Session    api    /auth    json=${data}
    Should Be Equal As Integers    ${resp.status_code}    200
    ${token}=    Set Variable    ${resp.json()["token"]}
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

Criar Reserva
    Create Session    api    ${BOOKER_URL}
    &{booking}=    Create Dictionary    firstname=Gabriel    lastname=Tester    totalprice=100    depositpaid=True    additionalneeds=Breakfast
    &{dates}=      Create Dictionary    checkin=2025-09-04    checkout=2025-09-10
    Set To Dictionary    ${booking}    bookingdates=${dates}
    ${resp}=    POST On Session    api    /booking    json=${booking}
    Should Be Equal As Integers    ${resp.status_code}    200
    ${BOOKING_ID}=    Set Variable    ${resp.json()["bookingid"]}
    Set Suite Variable    ${BOOKING_ID}

Editar Reserva
    &{headers}=    Create Dictionary    Cookie=token=${AUTH_TOKEN}
    &{update}=    Create Dictionary    firstname=Gabriel    lastname=Atualizado    totalprice=200    depositpaid=False
    &{dates}=      Create Dictionary    checkin=2025-09-05    checkout=2025-09-12
    Set To Dictionary    ${update}    bookingdates=${dates}
    ${resp}=    PUT On Session    api    /booking/${BOOKING_ID}    json=${update}    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    200
    Dictionary Should Contain Item    ${resp.json()}    lastname    Atualizado

Excluir Reserva
    &{headers}=    Create Dictionary    Cookie=token=${AUTH_TOKEN}
    ${resp}=    DELETE On Session    api    /booking/${BOOKING_ID}    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    201
