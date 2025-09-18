*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Criar Sessão API
    [Arguments]    ${url}
    Create Session    api    ${url}

Realizar Requisição GET
    [Arguments]    ${endpoint}
    ${resp}=    GET On Session    api    ${endpoint}
    RETURN    ${resp}

Realizar Requisição POST
    [Arguments]    ${endpoint}    ${data}
    ${resp}=    POST On Session    api    ${endpoint}    json=${data}
    RETURN    ${resp}

Realizar Requisição PUT
    [Arguments]    ${endpoint}    ${data}    ${headers}=${None}
    ${resp}=    PUT On Session    api    ${endpoint}    json=${data}    headers=${headers}
    RETURN    ${resp}

Realizar Requisição DELETE
    [Arguments]    ${endpoint}    ${headers}=${None}
    ${resp}=    DELETE On Session    api    ${endpoint}    headers=${headers}
    RETURN    ${resp}

Verificar Status Code
    [Arguments]    ${response}    ${expected_code}
    Should Be Equal As Integers    ${response.status_code}    ${expected_code}

Verificar JSON Contém
    [Arguments]    ${response}    ${key}    ${value}
    Dictionary Should Contain Item    ${response.json()}    ${key}    ${value}

Criar Dicionário
    [Arguments]    @{args}
    &{dict}=    Create Dictionary    @{args}
    RETURN    ${dict}

Adicionar Item ao Dicionário
    [Arguments]    ${dict}    ${key}    ${value}
    Set To Dictionary    ${dict}    ${key}    ${value}
    RETURN    ${dict}
