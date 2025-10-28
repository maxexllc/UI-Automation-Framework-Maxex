*** Settings ***
Library    Browser
Variables  ../locators/login_page.yaml
Variables  ../locators/dashboard_page.yaml

*** Variables ***
${DEFAULT_TIMEOUT}    10s

*** Keywords ***
Open Maxex
    [Arguments]    ${base_url}    ${browser}=${BROWSER}    ${headless}=${HEADLESS}
    New Browser    ${browser}    headless=${headless}
    # recordVideo and viewport are dictionaries loaded from YAML variable file
    New Context    viewport=${VIEWPORT}    recordVideo=${RECORD_VIDEO}
    New Page       ${base_url}
    Wait For Load State

Login With Env Credentials
    ${username}=    Get Environment Variable    MAXEX_USERNAME
    ${password}=    Get Environment Variable    MAXEX_PASSWORD
    Run Keyword If    '${username}' == '' or '${password}' == ''    Fail    MAXEX_USERNAME/MAXEX_PASSWORD are not set.
    Fill Text    ${USERNAME_INPUT}    ${username}
    Fill Text    ${PASSWORD_INPUT}    ${password}
    Click        ${LOGIN_BUTTON}
    Wait For Load State

Should See Dashboard
    Wait For Elements State    ${DASHBOARD_H1}    visible    timeout=${DEFAULT_TIMEOUT}
    ${text}=    Get Text    ${DASHBOARD_H1}
    Should Contain    ${text}    Welcome

Close Browser If Open
    Run Keyword And Ignore Error    Close Browser
