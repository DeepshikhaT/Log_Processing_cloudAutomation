*** Settings ***
Library           KafkaLibrary
Library           RESTLibrary
Library           OperatingSystem
Library           BuiltIn
Library           S3Library
Library           AthenaLibrary  # Custom library to run Athena queries

Suite Setup       Start Kafka and Consumers
Suite Teardown    Stop Kafka and Consumers

*** Variables ***
${KAFKA_TOPIC}    du-logs
${S3_BUCKET}      my-log-bucket
${ATHENA_QUERY}   SELECT * FROM logs_table WHERE log_type='call' LIMIT 10
${ATHENA_DB}      my_log_database
${BASE_URL}       http://du-node-api.example.com
${DATA_CALL_API}  /make_data_call
${VOICE_CALL_API} /make_voice_call
${THROUGHPUT_API} /test_throughput
${HANDOVER_API}   /configure_handover
${LAMBDA_FUNCTION_NAME}  logProcessorLambda

*** Test Cases ***

# Test log pipeline functionality
Validate Kafka Producer to S3
    [Tags]        kafka s3
    ${response}=  Execute Kafka Producer   ${KAFKA_TOPIC}  sample_log
    Should Be Equal  ${response}  Log sent successfully
    Wait Until Keyword Succeeds  1s  10s  S3 Should Contain Log   ${S3_BUCKET}  sample_log

Validate S3 Log Processing by Lambda
    [Tags]        s3 lambda
    Trigger Lambda Function  ${LAMBDA_FUNCTION_NAME}
    Wait Until Keyword Succeeds  1s  10s  S3 Should Contain Processed Log   ${S3_BUCKET}  processed_log

Run Athena Query and Validate Results
    [Tags]        athena
    ${result}=    Run Athena Query   ${ATHENA_DB}   ${ATHENA_QUERY}
    Log           ${result}
    Should Not Be Empty  ${result}

# Additional Network Test Cases
Make a Data Call
    [Tags]        network data_call
    ${response}=  POST Request  ${BASE_URL}${DATA_CALL_API}  headers={}  data={"call_type": "data"}
    Log           ${response}
    Should Contain  ${response}  "call_status: success"

Make a Voice Call
    [Tags]        network voice_call
    ${response}=  POST Request  ${BASE_URL}${VOICE_CALL_API}  headers={}  data={"call_type": "voice"}
    Log           ${response}
    Should Contain  ${response}  "call_status: success"

Throughput Test
    [Tags]        network throughput
    ${response}=  GET Request  ${BASE_URL}${THROUGHPUT_API}
    Log           ${response}
    Should Contain  ${response}  "throughput:"

Configure and Perform Handover
    [Tags]        network handover
    ${response}=  POST Request  ${BASE_URL}${HANDOVER_API}  headers={}  data={"source_node": "Node1", "target_node": "Node2"}
    Log           ${response}
    Should Contain  ${response}  "handover_status: success"
