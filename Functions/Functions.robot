*** Settings ***
Library             SeleniumLibrary                implicit_wait=2s
Variables           ../Resources/config.py
Library             DateTime    
Library             Dialogs    
Library             String    
Library             Collections   


*** Keywords ***

OpenWebBrowser
    Run Keyword If      '${WebBrowser}' in ['Chrome','firefox']               Open Browser        ${HomePage2}         ${WebBrowser}       options=add_argument( "${HeadStatus}"); add_argument( "${WindowSize}" )
    Run Keyword If      '${WebBrowser}' in ['edge','safari','Opera']          Open Browser        ${HomePage2}         ${WebBrowser}
    Maximize Browser Window
    Log                             Opened the browser successfully

Logoff
    #Click Element    xpath=//a[@title='Logoff']
    Close Browser