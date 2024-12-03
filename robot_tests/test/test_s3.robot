*** Settings ***
Library           S3Library

*** Test Cases ***
Verify Log Upload
    Check S3 Object Exists    log-storage-bucket    logs/1.log
