*** Settings ***
Library           KafkaLibrary

*** Test Cases ***
Test Kafka Producer
    Create Kafka Topic    distributed-logs
    Publish Kafka Message    distributed-logs    INFO: Test Message
    Verify Kafka Message    distributed-logs    INFO: Test Message
