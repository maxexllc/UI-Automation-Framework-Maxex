*** Settings ***
Resource    ../../resources/keywords/auth.resource
Variables   ../../variables/environments/${ENV}.yaml
Test Teardown    Close Browser If Open

*** Test Cases ***
Smoke - User Can Log In
    [Tags]    smoke    critical
    Open Maxex    ${BASE_URL}
    Login With Env Credentials
    Should See Dashboard
