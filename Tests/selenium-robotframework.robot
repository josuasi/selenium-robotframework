*** Settings ***
Library         OperatingSystem
Library         SeleniumLibrary                 implicit_wait=2
Library         RequestsLibrary
Resource        ../Functions/Functions.robot
Test Teardown   Close All Browsers


*** Variables ***
&{user_data}    name=morpheus    job=leader
${username}    standard_user
${pswd}    secret_sauce
${f_name}    Josua
${l_name}    Simanjuntak
${ZIP}    000000

*** Test Cases ***                               
Test-1            #GET SINGLE USER
   [Documentation]   GET SINGLE USER
   # Given user ID is 2
   Set Suite Variable    ${USER_ID}    2
   # When I send a GET request to /users/2
   ${response}=    GET    ${HomePage}/api/users/${USER_ID}
   Set Suite Variable    ${response}
   # Then the response status should be 200
   Should Be Equal As Numbers    ${response.status_code}    200
   # And the response should contain user data
   Should Contain    ${response.json()}    data
   
Test-2            #POST CREATE USER
   [Documentation]     POST CREATE USER
   # Given user data is set
   Set Suite Variable    ${user_data}        ${user_data}
   # When I send a POST request to /users
   ${response}=    POST    ${HomePage}/api/users    json=${user_data}
   Set Suite Variable    ${response}
   # Then the response status should be 201
   Should Be Equal As Numbers    ${response.status_code}    201
   # And the response should contain created user data
   Should Contain    ${response.json()}    name
   Should Contain    ${response.json()}    job

Test-3
   [Documentation]    Add items to the shopping cart and checkout
# Open Browser
   Open Browser         ${HomePage2}         Chrome         
#Log in with valid credentials
   Input Text           id=user-name    ${username}
   Input Text           id=password    ${pswd}
   Click Button         id=login-button
# And user adds items to the shopping cart
   Click Element        //div[@data-test="inventory-item"][contains(.,"Sauce Labs Fleece Jacket")]//button
   Click Element        //div[@data-test="inventory-item"][contains(.,"Sauce Labs Bolt T-Shirt")]//button
# And user proceeds to checkout
   Click Element        //div[@id="shopping_cart_container"]
# And user makesure the items
   Page Should Contain  Sauce Labs Fleece Jacket
   Page Should Contain  Sauce Labs Bolt T-Shirt
# And user continue to checkout
   Click Element        //button[@id="checkout"]
# And user fills in the checkout information
   Input Text           id=first-name    ${f_name}
   Input Text           id=last-name    ${l_name}
   Input Text           id=postal-code    ${ZIP}
   Click Button         id=continue
# And user gets an overview (shopping receipt)
   Page Should Contain  Sauce Labs Fleece Jacket
   Page Should Contain  Sauce Labs Bolt T-Shirt
   Page Should Contain  Payment Information
   Page Should Contain  Shipping Information
   Page Should Contain  Price Total 
# And user completes the checkout process
   Click Button         id=finish
# Then user should see the order confirmation message
   Page Should Contain    Thank you for your order

