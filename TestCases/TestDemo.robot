*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}        https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}          Chrome
${username_field}   //input[@name="username"]
${password_field}   //input[@type="password"]
${login_button}     //button[@type="submit"]
${logout_dropdown}  //p[@class='oxd-userdropdown-name']
${logout_link}      //li/a[@href="/web/index.php/auth/logout"]

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Username    Admin
    Input Password    admin123
    Submit Credentials
    Welcome Page Should Be Open
    User Logout
    Verify User logout successfully
    set selenium implicit wait    10seconds
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    sleep  5sec
    Maximize Browser Window
    Title Should Be    OrangeHRM

Input Username
    [Arguments]    ${username}
    Input Text    ${username_field}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${password_field}    ${password}

Submit Credentials
    Click Button    ${login_button}

Welcome Page Should Be Open
    Title Should Be    OrangeHRM

User Logout
    sleep  5sec
    set selenium implicit wait    10seconds
    click element    ${logout_dropdown}
    sleep  5sec
    click element    ${logout_link}

Verify User logout successfully
    sleep  5sec
    Title Should Be    OrangeHRM