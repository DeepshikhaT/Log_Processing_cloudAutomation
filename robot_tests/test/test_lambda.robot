*** Settings ***
Library           LambdaLibrary

*** Test Cases ***
Test Lambda Function
    Invoke Lambda Function    log_validator    {"key": "logs/1.log"}
    Should Contain    ${output}    "Log is valid"
